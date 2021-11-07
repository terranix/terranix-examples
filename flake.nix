{
  description = "terranix examples";

  outputs = { self }: {

    templates = {
      # nix flake init -t github:terranix/terranix-examples#aws-nixos-server
      aws-nixos-server = {
        path = ./aws-nixos-server;
        description = "deploy an nixos machine as ec2 on aws";
      };
      # nix flake init -t github:terranix/terranix-examples#flake
      flake = {
        path = ./flake;
        description = "shows how to use nix flakes and terranix";
      };
      # nix flake init -t github:terranix/terranix-examples#hcloud-nixos-server
      hcloud-nixos-server = {
        path = ./hcloud-nixos-server;
        description = "deploy an nixos machine on hcloud using nixinfect";
      };
    };

    # nix flake init -t github:terranix/terranix-examples
    defaultTemplate = self.templates.flake;
  };
}
