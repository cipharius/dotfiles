{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-20.09";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-20.09";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, ... }@inputs: {
    nixosConfigurations."${(import ./user.nix).hostname}" =
      inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system.nix
          ./hardware.nix
          inputs.home-manager.nixosModules.home-manager
        ];
      };
  };
}
