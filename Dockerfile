FROM caddy:2.10.2-builder AS builder

RUN xcaddy build latest --with github.com/caddy-dns/cloudflare@latest

FROM caddy:2.10.2

LABEL maintainer="Sonic <sonic@djls.io>"
LABEL org.opencontainers.image.description="Custom Caddy image with Cloudflare DNS support"
LABEL org.opencontainers.image.source=https://github.com/justereseau/caddy_custom_image
LABEL org.opencontainers.image.licenses=WTFPL

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
