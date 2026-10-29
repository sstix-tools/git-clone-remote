{
  description = "git-clone-remote - Copy branches and tags to another Git remote";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (system: pkgs: rec {
        default = git-clone-remote;
        git-clone-remote = pkgs.stdenvNoCC.mkDerivation {
          pname = "git-clone-remote";
          version = "1.0.0";
          src = ./.;

          nativeBuildInputs = [ pkgs.makeWrapper ];

          installPhase = ''
            mkdir -p $out/bin $out/share/zsh/site-functions
            install -D -m 0755 bin/git-clone-remote $out/bin/git-clone-remote
            install -D -m 0644 completion/_git-clone-remote $out/share/zsh/site-functions/_git-clone-remote
            wrapProgram $out/bin/git-clone-remote \
              --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.bash pkgs.git pkgs.gnugrep ]}
          '';

          meta = {
            description = "Copy branches and tags to another Git remote";
            mainProgram = "git-clone-remote";
            platforms = pkgs.lib.platforms.unix;
          };
        };
      });

      apps = forAllSystems (system: pkgs: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/git-clone-remote";
        };
      });
    };
}
