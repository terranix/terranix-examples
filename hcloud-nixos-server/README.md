# NixOS Server Example

This setup shows:

* how to use a terranix module
* how to run terranix and terraform

Deploy a
[NixOS servers](https://nixos.org/)
in
[hcloud](https://www.hetzner.com/cloud)
using
[nixos-infect](https://github.com/elitak/nixos-infect).

The [nginx](https://www.nginx.com/)
service is configured by a template generated by terraform
containing the IP addresses of the other
servers.
To access the domains you have to
update your `/etc/hosts`.

# How to Run

## What you need

* [passwordstore](https://www.passwordstore.org/).
  * a [hcloud token](https://docs.hetzner.cloud/#overview-getting-started) 
    stored under `development/hetzner.com/api-token`

## Steps

* `terranix-prepare`: to create ssh keys.
* `terranix-apply`: to run terranix and terraform.
* `terranix-destroy`: to delete server, ssh keys and terraform data.
  (don't forget that step, or else it gets costly)
