{ self', ... }:
let
  module = { ... }: {
    config = {
      programs.firefox = {
        package = self'.packages.firefox-bin;
      };
    };
  };
in
{
  flake.homeModules = {
    default = module;
    firefox-nix-darwin = module;
  };
}
