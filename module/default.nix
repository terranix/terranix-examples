{ config, lib, pkgs, ... }:
with lib;
with types;
let cfg = config.terranix.example.module;
in {
  options.terranix.example.module = {
    enable = mkEnableOption "example module";
    text = mkOption {
      type = str;
      description = "text of the example file";
    };
  };
  config = mkIf cfg.enable {
    resource.local_file = {
      content = cfg.text;
      filename = "example.txt";
    };
  };
}
