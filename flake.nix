{
  description = "macOS environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    apollo_configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs;
        [
            vim
            git
            wget
            python3
            rustup
            bat
            tmux
            screen
            jq
            btop
            exiftool
            sqlmap
            p7zip
            neofetch
            gcc
            hunspell
            ffuf
            pkg-config
            openssl
            go
            gox
            libiconv-darwin
            postgresql
            darwin.apple_sdk.frameworks.SystemConfiguration
            nixd
            nil
            nodejs
            devenv
            direnv
        ];

      nix.enable = false;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # security.pam.enableSudoTouchIdAuth = true;
      security.pam.services.sudo_local.touchIdAuth = true;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      programs.zsh.enable = true;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."apollo" = nix-darwin.lib.darwinSystem {
      modules = [ apollo_configuration ];
    };
  };
}
