final: prev: {
  secretaire-nvim = final.vimUtils.buildVimPlugin {
    pname = "secretaire-nvim";
    version = "0.1.0";
    src = ../modules/secretaire.nvim;
    installPhase = ''
      mkdir -p $out
      cd -r ./* $out/
    '';
  };
}
