{
  description = "example module";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    terranix.url = "github:terranix/terranix";
  };

  outputs = { self, nixpkgs, terranix, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          terranixOptions = terranix.lib.terranixOptions {
            inherit system;
            moduleRootPath = toString ./.;
            urlPrefix = "https://github.com/terranix/terranix-module-example/tree/main/module";
            modules = [{ imports = [ ./default.nix ]; }];
          };
        in
        {
          packages.options = terranixOptions;
          # to test the module
          # nix build
          defaultPackage = terranix.lib.terranixConfiguration {
            inherit system;
            modules = [
              self.terranixModule
              {
                terranix.example.module = {
                  enable = true;
                  text = "text";
                };
              }
            ];
          };
          # nix run
          defaultApp = self.apps.${system}.options;
          # generate option.json and option.md
          # nix run ".#options"
          apps.options =
            let
              mustacheTemplate = pkgs.writeText "template.mustache" ''
                # example module options

                <ul>
                {{#options}}
                <li>
                  <b><u>{{label}}</u></b><br>
                  <b>type</b>: {{type}}<br>
                  <b>default</b>: {{default}}<br>
                  <b>example</b>: {{example}}<br>
                  <b>defined</b>: <a href="{{url}}">{{defined}}</a><br>
                  <b>description</b>: {{description}}<br>
                </li>
                {{/options}}
                </ul>
              '';
            in
            {
              type = "app";
              program = toString (pkgs.writers.writeBash "options" ''
                cat ${terranixOptions} | ${pkgs.jq}/bin/jq 'to_entries | .[] |
                {
                  label: .key,
                  type: .value.type,
                  description: .value.description,
                  example: .value.example | tojson,
                  default: .value.default | tojson,
                  defined: .value.declarations[0].path,
                  url: .value.declarations[0].url,
                }' | ${pkgs.jq}/bin/jq -s '{ options: . }' \
                | ${pkgs.mustache-go}/bin/mustache ${mustacheTemplate} \
                > options.md
                cp -f ${terranixOptions} options.json
              '');
            };
        }) // {
      terranixModules.example = import ./default.nix;
      terranixModule.imports = [ self.terranixModules.example ];
    };
}
