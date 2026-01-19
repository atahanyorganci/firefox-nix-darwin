{ self', ... }:
let
  overlay = _final: _prev: {
    firefox-bin = self'.packages.firefox-bin;
  };
in
{
  flake.overlays = {
    firefox-nix-darwin = overlay;
    default = overlay;
  };
}
