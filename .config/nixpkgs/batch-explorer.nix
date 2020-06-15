{ pkgs, ... }:

let
    executableName = "batch-explorer";
    stdenv = pkgs.stdenv;
    rpath1 = pkgs.lib.makeLibraryPath [
        pkgs.alsaLib
        pkgs.atk
        pkgs.at-spi2-atk
        pkgs.cairo
        pkgs.cups
        pkgs.dbus
        pkgs.expat
        pkgs.fontconfig
        pkgs.freetype
        pkgs.gdk_pixbuf
        pkgs.glib
        pkgs.gnome2.GConf
        pkgs.gtk3
        pkgs.pango
        pkgs.libnotify
        pkgs.libuuid
        pkgs.nspr
        pkgs.nss
        pkgs.udev
        pkgs.xorg.libxcb
    ];
    rpath2 = pkgs.lib.concatStringsSep ":" [
      pkgs.atomEnv.libPath
      "${pkgs.lib.makeLibraryPath [pkgs.gtk2]}"
      "${pkgs.lib.makeLibraryPath [pkgs.gnome3.libsecret]}/libsecret-1.so.0"
      "${pkgs.lib.makeLibraryPath [pkgs.xorg.libXScrnSaver]}/libXss.so.1"
      "${pkgs.lib.makeLibraryPath [pkgs.xorg.libxkbfile]}/libxkbfile.so.1"
      "${pkgs.lib.makeLibraryPath [pkgs.libuuid]}/libuuid.so.1"
      "$out"
      "$out/batchlibexec"
    ];
    rpath = rpath1 + ":" + rpath2;
    dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;
in
  stdenv.mkDerivation rec {
    name = "batch-explorer-${version}";
    version = "2.5.0";

    src = pkgs.fetchurl {
      #url = "https://batchexplorer.azureedge.net/stable/0.19.2-stable.231/batch-explorer_0.19.2-stable.231_amd64.deb";
      url = "https://batchexplorer.azureedge.net/stable/2.5.0-stable.401/batch-explorer_2.5.0-stable.401_amd64.deb";
      sha256 = "0zw5q0ic2xr6zb9p306y2mivpqx0ngjz6gv2jbahp06jpc1py953";
    };

    phases = [ "unpackPhase" "installPhase" "fixupPhase" ];
    nativeBuildInputs = [ pkgs.nodePackages.asar pkgs.gtk2 pkgs.gnome3.libsecret pkgs.dpkg pkgs.wrapGAppsHook ];

    unpackPhase = "dpkg-deb -x $src .";

#[Desktop Entry]
#Name=BatchExplorer
#Comment=Batch Explorer is a tool to manage your Azure Batch accounts
#Exec="/opt/BatchExplorer/batch-explorer" %U
#Terminal=false
#Type=Application
#Icon=batch-explorer
#StartupWMClass=BatchExplorer
#MimeType=x-scheme-handler/ms-batchlabs;x-scheme-handler/ms-batch-explorer;
#Categories=Development;

    desktopItem = pkgs.makeDesktopItem {
        name = "batch-explorer";
        desktopName = "Batch Explorer";
        comment = "Batch Explorer is a tool to manage your Azure Batch accounts";
        exec = "batch-explorer";
        icon = "@out@/share/icons/hicolor/128x128/apps/batch-explorer.png";
        mimeType = "x-scheme-handler/ms-batchlabs;x-scheme-handler/ms-batch-explorer;";
        extraEntries = ''
          Comment=Batch Explorer is a tool to manage your Azure Batch accounts
          Exec="@out@/bin/batch-explorer" %U
          Terminal=false
          Type=Application
          StartupWMClass=BatchExplorer
          Categories=Development;
        '';
      };

    installPhase = ''
      mkdir -p $out
      cp -R opt $out
      mv ./usr/share $out/share
      mv $out/opt/BatchExplorer $out/batchlibexec
      rmdir $out/opt
      chmod -R g-w $out

      # unpack, patch repack app.asar
      asar e $out/batchlibexec/resources/app.asar $out/batchlibexec/resources/app.asar-unpacked

      patchelf \
        --set-rpath "${rpath}" \
        $out/batchlibexec/resources/app.asar-unpacked/node_modules/keytar/build/Release/keytar.node

      rm -v $out/batchlibexec/resources/app.asar
      asar p $out/batchlibexec/resources/app.asar-unpacked $out/batchlibexec/resources/app.asar


      mkdir -p $out/share/applications
      substitute $desktopItem/share/applications/batch-explorer.desktop $out/share/applications/batch-explorer.desktop \
        --subst-var out
    '';


    fixupPhase = ''
      # Patch batch explorer
      patchelf \
        --set-interpreter "${dynamic-linker}" \
        --set-rpath "${rpath}" \
        $out/batchlibexec/batch-explorer
      wrapProgram $out/batchlibexec/batch-explorer \
        --prefix XDG_DATA_DIRS : "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/" \
        --prefix LD_LIBRARY_PATH : "${stdenv.cc.cc.lib}/lib"

      # Symlink to bin
      mkdir -p $out/bin
      ln -s $out/batchlibexec/batch-explorer $out/bin/batch-explorer
    '';
  }
