
FROM ubuntu:24.10

LABEL name="httpbin"
LABEL version="0.9.2"
LABEL description="A simple HTTP service."
LABEL org.kennethreitz.vendor="Kenneth Reitz"

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ARG PYTHON_VERSION="3.12"
ENV PYTHON="python$PYTHON_VERSION"
ARG PIP_VERSION="24.3.1"
ARG POETRY_VERSION="1.8.4"

ARG PYTHON_PACKAGES="$PYTHON $PYTHON-venv"
ARG ESSENTIAL_PACKAGES="$PYTHON_PACKAGES libffi-dev"

RUN apt update -y && \
    apt install -y $ESSENTIAL_PACKAGES && \
    rm -rf /var/lib/apt/lists/*

# Install Poetry, PIP and Setuptools in a virtual environment
ENV POETRY_HOME=/opt/poetry-venv
RUN $PYTHON -m venv $POETRY_HOME && \
    $POETRY_HOME/bin/pip install \
    pip==$PIP_VERSION \
    poetry==$POETRY_VERSION

# Create project virtual environment for application dependencies
ENV VIRTUAL_ENV=/opt/project-venv \
    PATH="/opt/project-venv/bin:$POETRY_HOME/bin:$PATH"
RUN python -m venv $VIRTUAL_ENV

# Copy project dependencies configuration
COPY pyproject.toml poetry.lock /

WORKDIR /httpbin

RUN poetry install

ADD . /httpbin

ARG PORT=8080
ENV PORT $PORT
EXPOSE $PORT

ARG options
ENV OPTIONS $options

CMD exec gunicorn $OPTIONS --bind :$PORT -k gevent httpbin:app
