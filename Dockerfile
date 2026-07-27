# renovate: datasource=docker depName=caddy
ARG CADDY_VERSION=2.11.4

FROM caddy:${CADDY_VERSION}-builder AS builder

# Re-declare inside the stage so the global ARG is available to RUN.
ARG CADDY_VERSION

# Build the same Caddy version as the base image (follow the source version).
RUN xcaddy build "v${CADDY_VERSION}" --with github.com/caddy-dns/cloudflare@latest

FROM caddy:${CADDY_VERSION}

LABEL maintainer="Sonic <sonic@djls.io>"
LABEL org.opencontainers.image.description="Custom Caddy image with Cloudflare DNS support"
LABEL org.opencontainers.image.source=https://github.com/justereseau/caddy_custom_image
LABEL org.opencontainers.image.licenses=WTFPL

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
