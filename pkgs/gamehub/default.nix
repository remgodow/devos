{ stdenv
, lib
, fetchFromGitHub
, meson
, ninja
, vala
, pkg-config
, desktop-file-utils
, glib
, gtk3
, libgee
, libsoup
, json-glib
, sqlite
, webkitgtk
, libmanette
, libXtst
, libxml2
, polkit
, glib-networking
, wrapGAppsHook
}:

stdenv.mkDerivation rec {
  pname = "gamehub";
  version = "0.16.1-2";

  src = fetchFromGitHub {
    owner = "tkashkin";
    repo = "GameHub";
    rev = "${version}-master";
    sha256 = "08hxswd2j25z78akxbmbkb29rdcnx8z7j5jca3p7x1vb7ilq17dy";
  };

  nativeBuildInputs = [
    meson
    ninja
    vala
    pkg-config
    desktop-file-utils
    wrapGAppsHook

  ];

  buildInputs = [
    glib
    gtk3
    libgee
    libsoup
    json-glib
    sqlite
    webkitgtk
    libmanette
    libXtst
    libxml2
    polkit
    glib-networking
  ];

  meta = with lib; {
    description = "All your games in one place";
    homepage = "https://tkashkin.tk/projects/gamehub/";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
