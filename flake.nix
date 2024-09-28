{

  description = "My first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = {self, nixpkgs, nixpkgs-unstable, home-manager,...}:
    let
       system = "x86_64-linux"; 
       lib = nixpkgs.lib;
       pkgs = nixpkgs.legacyPackages.${system};
       pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in {
      nixosConfigurations = {
       rosie = lib.nixosSystem {
           inherit system;
           modules = [ ./configuration.nix ];
           specialArgs = {
             inherit pkgs-unstable;
            };
          };
        };
      homeConfigurations = {
       ernstrom = home-manager.lib.homeManagerConfiguration {
           inherit pkgs;
           modules = [ ./home.nix ];
     }; 
   };
  };
}
