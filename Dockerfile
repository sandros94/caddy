FROM golang AS builder
WORKDIR /usr/bin
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

ARG CADDY_TAG=master            #caddy version; it can be a tag, a branch or a commit hash
ARG L4_TAG=master               #caddy-l4 version
RUN xcaddy build ${CADDY_TAG} \
    --with github.com/mholt/caddy-l4@${L4_TAG}

FROM caddy:latest AS dist
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
