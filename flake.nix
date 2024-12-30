{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let 
    mkSystem = system: location: nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        ./hosts/${location}/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
      specialArgs = {inherit inputs;};
    };

  in {
    nixosConfigurations = {
      default = mkSystem "x86_64-linux" "default";
      minibox = mkSystem "x86_64-linux" "minibox";
    };
  };
}

