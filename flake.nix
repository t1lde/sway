{
  description = "sway dev shell";

  inputs = {
    nixpkgs.url = "nixpkgs/master";
  };

  outputs = inputs@{
    self, nixpkgs, ...
  }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      wlroots =
        pkgs.wlroots.overrideAttrs (old: rec {
          src = fetchGit {
            url = "https://gitlab.freedesktop.org/wlroots/wlroots.git";
            rev = "104060fec57bec2a282c52f7e849f40fd1b1b45e";
          };
          version = "0.16.0";
        });
    in
      {
        devShell.${system} = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            git clang meson ninja
            wlroots wayland wayland-protocols pcre2 json_c pango cairo gdk-pixbuf scdoc
            pkgconfig libxkbcommon libevdev libinput libdrm
          ];
        };
      };

}
