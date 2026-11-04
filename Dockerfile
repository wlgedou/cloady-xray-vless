FROM alpine:3.20 AS builder
RUN apk add --no-cache curl unzip ca-certificates && mkdir -p /tmp/xray && cd /tmp/xray && curl -L -o Xray-linux-64.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && unzip Xray-linux-64.zip && chmod +x xray && cp xray /usr/local/bin/xray
FROM alpine:3.20
RUN apk add --no-cache ca-certificates
COPY --from=builder /usr/local/bin/xray /usr/local/bin/xray
COPY config.json /etc/xray/config.json
EXPOSE 3000
ENTRYPOINT ["/bin/sh", "-c", "/usr/local/bin/xray run -c /etc/xray/config.json"]
