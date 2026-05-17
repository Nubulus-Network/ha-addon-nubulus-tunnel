# Stage 1: extract the tunnel-agent binary from the upstream image
FROM code.as210469.net/nubulusnetworkopensource/tunnel:v3.0.0 AS extract

# Stage 2: build the final add-on image on top of the HA base
FROM ghcr.io/home-assistant/base:latest

LABEL io.hass.version="1.0.0"
LABEL io.hass.type="addon"
LABEL io.hass.arch="amd64"

COPY --from=extract /usr/local/bin/tunnel-agent /usr/local/bin/tunnel-agent
COPY run.sh /run.sh

RUN chmod +x /usr/local/bin/tunnel-agent /run.sh

CMD ["/run.sh"]
