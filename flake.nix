# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-sun20iw1p1.url = "/home/lucas/Documents/code/nixos-sun20iw1p1";
    rust-gps.url = "/home/lucas/Documents/code/gps/";
  };
  
  outputs = { self, nixpkgs, nixos-sun20iw1p1, rust-gps }@inputs: {
    nixosConfigurations.myLicheeRV = let args = inputs; in nixpkgs.lib.nixosSystem {
      modules = [
        {
          _module.args = args;
        }
        nixos-sun20iw1p1.nixosModules.sd-image-licheerv
        ./configuration.nix
        ({ pkgs, config, ... }: {
          nixpkgs.buildPlatform = "x86_64-linux";
        })
      ];
    };
  };
}
