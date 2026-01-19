{ self', ... }:
let
  overlay = final: prev: {
    firefox-bin = self'.packages.firefox-bin;
  };
in
{
  flake.overlays = {
    firefox-nix-darwin = overlay;
    default = overlay;
  };
}
