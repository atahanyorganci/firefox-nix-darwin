{ self', ... }:
let
  module = { pkgs, config, lib, ... }: {
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
