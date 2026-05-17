ARG BUILD_FROM
ARG TUNNEL_VERSION=v3.0.0

# Stage 1: extract the tunnel-agent binary from the upstream multi-arch image
FROM code.as210469.net/nubulusnetworkopensource/tunnel:${TUNNEL_VERSION} AS extract

# Stage 2: build the final add-on image on top of the HA base
FROM ${BUILD_FROM}

ARG BUILD_ARCH

LABEL io.hass.version="1.0.3"
LABEL io.hass.type="addon"
LABEL io.hass.arch="${BUILD_ARCH}"

COPY --from=extract /usr/local/bin/tunnel-agent /usr/local/bin/tunnel-agent
COPY run.sh /run.sh

RUN chmod +x /usr/local/bin/tunnel-agent /run.sh

CMD ["/run.sh"]
