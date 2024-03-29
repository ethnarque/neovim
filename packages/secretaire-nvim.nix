final: prev: {
  core-nvim = final.vimUtils.buildVimPlugin {
    pname = "core-nvim";
    version = "0.1.0";
    src = ../modules/core.nvim;
    installPhase = ''
      mkdir -p $out
      cd -r ./* $out/
    '';
  };
}
