{
  perSystem = { pkgs, ... }:
    let
      firefox = builtins.fromJSON (builtins.readFile ./firefox.json);
    in
    {
      packages.firefox-bin = pkgs.stdenv.mkDerivation rec {
        pname = "Firefox";
        version = firefox.version;
        buildInputs = [ pkgs.undmg ];
        sourceRoot = ".";
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p "$out/Applications"
          cp -r Firefox.app "$out/Applications/Firefox.app"
        '';
        src = pkgs.fetchurl {
          name = "Firefox-${version}.dmg";
          inherit (firefox) url sha256;
        };
        meta = with pkgs.lib; {
          description = "The Firefox web browser";
          homepage = "https://www.mozilla.org/en-GB/firefox";
          platforms = platforms.darwin;
        };
      };
    };
}
