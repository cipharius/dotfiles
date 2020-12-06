self: super:
{
  agkozak-zsh-prompt = self.callPackage ./nix/packages/agkozak-zsh-prompt.nix { };

  kakoune-surround = self.callPackage ./nix/packages/kakoune-surround.nix { };
  kakoune-rainbow = self.callPackage ./nix/packages/kakoune-rainbow.nix { };
}
