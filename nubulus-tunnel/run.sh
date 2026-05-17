#!/usr/bin/with-contenv bashio

TUNNEL_TOKEN=$(bashio::config 'tunnel_token')
LOG_LEVEL=$(bashio::config 'log_level')
API_URL=$(bashio::config 'api_url')

if bashio::var.is_empty "${TUNNEL_TOKEN}"; then
    bashio::log.fatal "tunnel_token is required. Set it in the add-on configuration."
    exit 1
fi

export TUNNEL_TOKEN
export LOG_LEVEL
export API_URL

bashio::log.info "Starting Nubulus Tunnel agent (log_level=${LOG_LEVEL})"

exec /usr/local/bin/tunnel-agent
