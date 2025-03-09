ARG CADDY_VERSION=2.9.1
FROM caddy:${CADDY_VERSION}-builder AS builder

RUN xcaddy build \
  --with github.com/lucaslorentz/caddy-docker-proxy/v2@7c489f0e193efaf57aaaed07da9cc713c55054d1 \
  --with github.com/caddyserver/cache-handler \
  --with github.com/mholt/caddy-l4

ARG CADDY_VERSION=2.9.1
FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "docker-proxy"]
