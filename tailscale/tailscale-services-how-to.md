# Serve via via tailscale subdomain

Make services reachable via e.g.

```text
https://navidrome.<tailscale-dns-name>.com
```


## Admin Console Setup

If the service host needs a tag-based identity, define a tag owner in the Tailscale ACL/policy file first:

Open the Tailscale admin console:

```text
https://login.tailscale.com/admin/services
```

Create the services:

```text
immich
jellyfin
navidrome
```

Each with port:

```text
tcp:443
```

and tag:

```text
tag:server
```

Configure the tags from there (Manage tags in Access Controls) or via [Access Controls](https://login.tailscale.com/admin/acls/file)

```json
"tagOwners": {
  "tag:server": ["autogroup:admin"]
}
```

## Serve on Home Server

Then advertise the tag from the home server:

```sh
sudo tailscale up --advertise-tags=tag:server
```

And serve:

```shell
sudo tailscale serve --service=svc:navidrome --https=443 http://localhost:4533
sudo tailscale serve --service=svc:immich --https=443 http://localhost:2283
sudo tailscale serve --service=svc:jellyfin --https=443 http://localhost:8096
```

Check the config:

```sh
sudo tailscale serve get-config --all
```

Expected config:

```json
{
  "version": "0.0.1",
  "services": {
    "svc:immich": {
      "endpoints": {
        "tcp:443": "http://localhost:2283"
      }
    },
    "svc:jellyfin": {
      "endpoints": {
        "tcp:443": "http://localhost:8096"
      }
    },
    "svc:navidrome": {
      "endpoints": {
        "tcp:443": "http://localhost:4533"
      }
    }
  }
}
```

## Approve Services

After running the serve commands, go back to:

```text
Admin console -> Services
```

Open each service and approve the advertised host if required.

The service should move to `Connected` once the host is approved and correctly configured.

### Check Service Host State

Run:

```sh
tailscale status --json | jq '.Self.CapMap."service-host"'
```

This shows whether the current machine is advertising Tailscale Services correctly.

## Useful Commands

Show status:

```sh
sudo tailscale serve status
```

Show full service config:

```sh
sudo tailscale serve get-config --all
```

Advertise services:

```sh
sudo tailscale serve advertise svc:service-name
```

Remove service config:

```sh
sudo tailscale serve --service=svc:service-name --https=443 off
sudo tailscale serve clear svc:service-name
```

Reset all serve configuration:

```sh
sudo tailscale serve reset
```
