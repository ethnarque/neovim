{ }
# final: prev: {
#   plugins-nvim = final.vimUtils.buildVimPlugin {
#     pname = "plugins-nvim";
#     version = "0.1.0";
#     src = ./.;
#     installPhase = ''
#       mkdir -p $out
#       cd -r ./* $out/
#     '';
#   };
# }
