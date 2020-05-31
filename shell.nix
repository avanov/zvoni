with (import (builtins.fetchTarball {
    # https://nixos.wiki/wiki/FAQ/Pinning_Nixpkgs
    # Descriptive name to make the store path easier to identify
    name = "nixpkgs-avanov-ats";
    url = https://github.com/avanov/nixpkgs/archive/ad015b00eee415a261469fd667fa468a9be07e8e.tar.gz;
    # Hash obtained using `nix-prefetch-url --unpack <url>`
    sha256 = "0iqh010w88bzqzqd0xq4vnigdw4wj778is3g220wznaa80bil8mw";
}) {});


let
    macOsDeps = with pkgs; stdenv.lib.optionals stdenv.isDarwin [
        darwin.apple_sdk.frameworks.CoreServices
        darwin.apple_sdk.frameworks.ApplicationServices
    ];
    darwin-h2o = pkgs.h2o.overrideAttrs (oldAttrs: rec {
        meta = with stdenv.lib; {
            description = oldAttrs.meta.description;
            homepage    = oldAttrs.meta.homepage;
            license     = oldAttrs.meta.license;
            maintainers = oldAttrs.meta.maintainers;
            platforms   = oldAttrs.meta.platforms ++ platforms.darwin;
        };
    });
in

# Make a new "derivation" that represents our shell
stdenv.mkDerivation {
    name = "artsy";
    buildInputs = [
        # see https://nixos.org/nixos/packages.html
        # Python distribution
        gmp
        darwin-h2o
        ats2
        libressl
        cacert
        which
        gnumake
    ] ++ macOsDeps;
    shellHook = ''
        # Set SOURCE_DATE_EPOCH so that we can use python wheels.
        # This compromises immutability, but is what we need
        # to allow package installs from PyPI
        export SOURCE_DATE_EPOCH=$(date +%s)

        # Dirty fix for Linux systems
        # https://nixos.wiki/wiki/Packaging/Quirks_and_Caveats
        export LD_LIBRARY_PATH=${stdenv.cc.cc.lib}/lib/:$LD_LIBRARY_PATH
    '';
}
