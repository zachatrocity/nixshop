# pkgs/sddm-astronaut-theme.nix
{ stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation {
  pname = "sddm-astronaut-theme";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "Keyitdev";
    repo = "sddm-astronaut-theme";
    rev = "7123e38";
    sha256 = "sha256-DOzsmXwFjG8GlD8TkXMCjCQzTU9Fc/S7MUGm5b8OWlY="; 
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -r $src $out/share/sddm/themes/astronaut
  '';
}