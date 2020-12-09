self: super:
{
  kak-connect = self.callPackage ./nix/packages/kak-connect.nix { };
  kak-prelude = self.callPackage ./nix/packages/kak-prelude.nix { };
}
