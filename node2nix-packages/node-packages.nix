# This file has been generated by node2nix 1.11.1. Do not edit!

{nodeEnv, fetchurl, fetchgit, nix-gitignore, stdenv, lib, globalBuildInputs ? []}:

let
  sources = {
    "core_d-5.0.1" = {
      name = "core_d";
      packageName = "core_d";
      version = "5.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/core_d/-/core_d-5.0.1.tgz";
        sha512 = "37lZyhJY1hzgFbfU4LzY4zL09QPwPfV2W/3YBOtN7mkdvVaeP1OVnDZI6zxggtlPwG/BuE5wIr0xptlVJk5EPA==";
      };
    };
    "has-flag-4.0.0" = {
      name = "has-flag";
      packageName = "has-flag";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/has-flag/-/has-flag-4.0.0.tgz";
        sha512 = "EykJT/Q1KjTWctppgIAgfSO0tKVuZUjhgMr17kqTumMl6Afv3EISleU7qZUzoXDFTAHTDC4NOoG/ZxU3EvlMPQ==";
      };
    };
    "nanolru-1.0.0" = {
      name = "nanolru";
      packageName = "nanolru";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/nanolru/-/nanolru-1.0.0.tgz";
        sha512 = "GyQkE8M32pULhQk7Sko5raoIbPalAk90ICG+An4fq6fCsFHsP6fB2K46WGXVdoJpy4SGMnZ/EKbo123fZJomWg==";
      };
    };
    "prettier-2.8.7" = {
      name = "prettier";
      packageName = "prettier";
      version = "2.8.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/prettier/-/prettier-2.8.7.tgz";
        sha512 = "yPngTo3aXUUmyuTjeTUT75txrf+aMh9FiD7q9ZE/i6r0bPb22g4FsE6Y338PQX1bmfy08i9QQCB7/rcUAVntfw==";
      };
    };
    "supports-color-8.1.1" = {
      name = "supports-color";
      packageName = "supports-color";
      version = "8.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/supports-color/-/supports-color-8.1.1.tgz";
        sha512 = "MpUEN2OodtUzxvKQl72cUF7RQ5EiHsGvSsVG0ia9c5RbWGL2CI4C7EpPS8UTBIplnlzZiNuV56w+FuNxy3ty2Q==";
      };
    };
  };
in
{
  "@fsouza/prettierd" = nodeEnv.buildNodePackage {
    name = "_at_fsouza_slash_prettierd";
    packageName = "@fsouza/prettierd";
    version = "0.23.3";
    src = fetchurl {
      url = "https://registry.npmjs.org/@fsouza/prettierd/-/prettierd-0.23.3.tgz";
      sha512 = "O253Z26eX0u2mwVkLQVIOO8+ll69kHGLdzw9P/LWd9OUIs8v4GnL5av4vfahpqYiFdVXnVGBcJwhFSyUJ3eFLg==";
    };
    dependencies = [
      sources."core_d-5.0.1"
      sources."has-flag-4.0.0"
      sources."nanolru-1.0.0"
      sources."prettier-2.8.7"
      sources."supports-color-8.1.1"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "prettier, as a daemon";
      homepage = "https://github.com/fsouza/prettierd";
      license = "ISC";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
}
