FROM golang:1.20.6-alpine3.18 AS builder
RUN mkdir /app
COPY ./ /app
WORKDIR /app
RUN go build -o gabriel . 

FROM alpine:latest AS runtime
RUN mkdir /app
WORKDIR /app
COPY --from=builder /app/gabriel /app/
RUN chmod +x /app/gabriel
# COPY ./config.yaml /app/config.yaml

EXPOSE 80

# RUN apk del apk-tools
# ENV PATH "/app:$PATH"
# ENV LOG_LEVEL info
# ENV LOG_FILE "/app/dns.log"
# ENV CONFIG_FILE "/app/config.yaml"

# watching is not supported in container
# ENV WATCH_CONFIG_FILE "false"

ENTRYPOINT [ "/app/gabriel" ]
