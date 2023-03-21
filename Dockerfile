FROM alpine:edge

RUN echo -e  "\nhttps://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add --update --no-cache go git make musl-dev curl openssl
RUN mkdir -p /app/src
WORKDIR /app/src
ARG appRoot=/app
COPY appbuild.sh /app/src
RUN chmod +x appbuild.sh
RUN ./appbuild.sh
COPY sign.sh /app/src
WORKDIR /
COPY entrypoint.sh /
RUN chmod +x entrypoint.sh
EXPOSE 3000
ENTRYPOINT ./entrypoint.sh
