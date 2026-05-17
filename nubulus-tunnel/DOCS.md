# Nubulus Tunnel

## About

The Nubulus Tunnel add-on connects your Home Assistant instance to the internet
through a secure [Nubulus Network](https://nubulusnetwork.es) tunnel — no open
ports, no public IP address, and no router configuration required.

The add-on runs the Nubulus tunnel agent, a lightweight Go binary that
establishes an outbound WireGuard tunnel (userspace, no kernel modules needed)
to the Nubulus gateway. Incoming HTTPS requests for your configured hostname are
forwarded by the gateway through the tunnel to your Home Assistant instance.

## Prerequisites

1. A Nubulus Network account — sign up at [app.nubulusnetwork.es](https://app.nubulusnetwork.es).
2. A tunnel created from the Nubulus dashboard.
3. A route configured in the tunnel pointing to `homeassistant:8123` (or
   whichever upstream host/port your HA instance listens on).
4. The tunnel token (`tun_xxxxxxx`) copied from the dashboard.

## Installation

1. In Home Assistant, go to **Settings → Add-ons → Add-on Store**.
2. Click the overflow menu (⋮) and select **Repositories**.
3. Add the repository URL:
   ```
   https://github.com/Nubulus-Network/ha-addon-nubulus-tunnel
   ```
4. Find **Nubulus Tunnel** in the store and click **Install**.
5. Open the add-on **Configuration** tab and paste your tunnel token.
6. Click **Save**, then **Start**.

## Configuration

| Option | Required | Default | Description |
|---|---|---|---|
| `tunnel_token` | Yes | — | Token from your Nubulus tunnel (format: `tun_xxxxxxx`). |
| `log_level` | No | `info` | Logging verbosity: `debug`, `info`, `warn`, or `error`. |

## How it works

```
Internet → Nubulus gateway (UDP 51820 / WireGuard)
               ↕  encrypted tunnel (outbound only)
         Nubulus Tunnel agent (this add-on)
               ↕  reverse proxy
         Home Assistant (homeassistant:8123)
```

1. You create a tunnel and configure routes in the Nubulus panel.
2. The agent authenticates with the API using the tunnel token and receives the
   WireGuard configuration.
3. The agent opens an outbound WireGuard tunnel to the gateway — no inbound
   ports need to be opened on your router or firewall.
4. The gateway forwards incoming HTTPS traffic for your hostname through the
   tunnel to your Home Assistant instance.

## Troubleshooting

**Add-on fails to start**
- Check the add-on logs for error messages.
- Ensure the `tunnel_token` field is filled in and starts with `tun_`.

**Tunnel connects but Home Assistant is not reachable**
- Verify the route in the Nubulus dashboard points to `homeassistant:8123`.
- Confirm Home Assistant is running and accessible on port 8123 inside the HA
  network.

**Connectivity issues**
- The agent requires outbound access on:
  - TCP 443 (HTTPS) to the Nubulus API.
  - UDP 51820 to the Nubulus gateway.
- Check that your network/firewall does not block outbound UDP 51820.

**Increase verbosity**
- Set `log_level` to `debug` in the add-on configuration and restart to get
  detailed tunnel logs.
