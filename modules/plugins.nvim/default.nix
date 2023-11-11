final: prev: {
  core-plugins-nvim = final.vimUtils.buildVimPlugin {
    pname = "core-plugins-nvim";
    version = "0.1.0";
    src = ./.;
    installPhase = ''
      mkdir -p $out
      cd -r ./* $out/
    '';
  };
}
