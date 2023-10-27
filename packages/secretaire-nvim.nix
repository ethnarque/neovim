final: prev: {
  secretaire-nvim = final.vimUtils.buildVimPluginFrom2Nix {
    pname = "secretaire-nvim";
    version = "0.1.0";
    src = ../modules/secretaire.nvim;
    installPhase = ''
      mkdir -p $out
      cd -r ./* $out/
    '';
  };
}
