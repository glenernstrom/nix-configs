{

  description = "My first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = {self, nixpkgs, nixpkgs-unstable, ...}:
    let
       system = "x86_64-linux"; 
       lib = nixpkgs.lib;
       pkgs = nixpkgs.legacyPackage.${system};
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
  };
}
