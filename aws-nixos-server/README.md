# NixOS on AWS

This setup shows:

* how to include external files
* how to run terranix and terraform

Create a nixos machine in
[amazon aws](https://aws.amazon.com).

# How to Run

## What you need

* [passwordstore](https://www.passwordstore.org/).
  * an [access id](https://aws.amazon.com/premiumsupport/knowledge-center/create-access-key) 
    stored under `development/aws/access_id`
  * an [secret key](https://aws.amazon.com/premiumsupport/knowledge-center/create-access-key) 
    stored under `development/aws/secret_key`

## Steps

* run `nix-shell`: to start sandbox.
* `terranix-prepare`: to create ssh keys.
* `terranix-apply`: to run terranix and terraform.
* `terranix-destroy`: to delete server, ssh keys and terraform data. 
  (don't forget that step, or else it gets costly)
