{
  perSystem = { pkgs, ... }:
    let
      manifest = "./packages/firefox-bin/firefox.json";
      latest-firefox-version = pkgs.writeShellScriptBin "latest-firefox-version" ''
        set -e
        version=$(curl -s 'https://product-details.mozilla.org/1.0/firefox_versions.json' | jq -r '.LATEST_FIREFOX_VERSION')
        echo "Last version of Firefox is $version" >&2
        name="Firefox-$version.dmg"
        url="https://download-installer.cdn.mozilla.net/pub/firefox/releases/$version/mac/en-GB/Firefox%20$version.dmg"
        sha256=$(nix-prefetch-url --name $version $url)
        echo "SHA256 of $name is $sha256" >&2
        jq -n -r \
          --arg version "$version" \
          --arg sha256 "$sha256" \
          --arg url "$url" \
          '{version: $version, url: $url, sha256: $sha256}'
      '';
      ci = pkgs.writeShellScriptBin "ci" ''
        set -e
        latest-firefox-version > ${manifest}
        version=$(jq -r '.version' ${manifest})
        git config --global user.name "github-actions"
        git config --global user.email "github-actions[bot]@users.noreply.github.com"
        git diff --quiet || (git add ${manifest} && git commit -m "chore: bump Firefox to $version")
        git push
      '';
    in
    {
      packages = {
        inherit latest-firefox-version ci;
      };
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          jq
          curl
          git
          latest-firefox-version
          ci
        ];
      };
    };
}
