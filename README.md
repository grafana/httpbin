# k6 HTTPBin Play: HTTP Request & Response Service

An HTTPBin site to help you familiarize yourself with k6, deployed at https://k6-http.grafana.fun/.

This project is a fork of [httpbin](https://github.com/kennethreitz/httpbin) by [Kenneth Reitz](http://kennethreitz.org/bitcoin).

## Update requirements

Install locally the same Poetry version that is defined in `Dockerfile`,
and then run:

```sh
poetry lock
```

## Run in Docker

You can deploy or run this project locally using the [`grafana/k6-httpbin` Docker Image](https://hub.docker.com/r/grafana/k6-httpbin):

```sh
docker pull grafana/k6-httpbin
docker run -p 8080:8080 grafana/k6-httpbin
```

> When running on Mac M1, pass the option: `--platform linux/x86_64`  

You should now be able to access it at http://localhost:8080/

For development:

```sh
docker build -t httpbin .
docker run -p 8080:8080  -it httpbin:latest
```
