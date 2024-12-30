# fonts.nix
{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.iosevka
      font-awesome
      material-design-icons
      material-symbols
    ];
  };

  fonts.fontconfig.enable = true;
}
