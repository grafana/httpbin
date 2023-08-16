FROM ubuntu:18.04

LABEL name="httpbin"
LABEL version="0.9.2"
LABEL description="A simple HTTP service."
LABEL org.kennethreitz.vendor="Kenneth Reitz"

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt update -y && apt install python3-pip libffi-dev git -y && pip3 install --no-cache-dir pipenv==2022.4.8

ADD Pipfile Pipfile.lock /httpbin/
WORKDIR /httpbin
RUN /bin/bash -c "pip3 install --no-cache-dir -r <(pipenv lock -r)"

ADD . /httpbin
RUN pip3 install --no-cache-dir /httpbin

ARG PORT=8080
ENV PORT $PORT
EXPOSE $PORT

ARG options
ENV OPTIONS $options

CMD exec gunicorn $OPTIONS --bind :$PORT -k gevent httpbin:app