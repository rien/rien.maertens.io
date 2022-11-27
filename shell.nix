let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    imagemagick
    pandoc
    texlive.combined.scheme-small
    wkhtmltopdf
    ruby_3_1
    nodejs
    taglib
    zlib
  ];
  shellHook = ''
    export GEM_HOME="$PWD/vendor/bundle/$(ruby -e 'puts RUBY_VERSION')"
    export PATH="$GEM_HOME/bin:$PATH"
  '';
}
