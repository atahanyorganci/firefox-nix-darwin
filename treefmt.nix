{
  perSystem = { pkgs, ... }: {
    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
        deadnix.enable = true;
        mdsh.enable = true;
        nixpkgs-fmt.enable = true;
        shellcheck.enable = pkgs.hostPlatform.system != "riscv64-linux";
        shfmt = {
          enable = pkgs.hostPlatform.system != "riscv64-linux";
          indent_size = 4;
        };
      };
    };
  };
}
