{ stdenv
, lib
, makeDesktopItem
, makeWrapper
, patchelf
, writeText
, coreutils
, gnugrep
, which
, git
, unzip
, libsecret
, libnotify
, e2fsprogs
, zlib
, jetbrains
, fetchurl
, vmopts ? null
}:

with stdenv; lib.makeOverridable mkDerivation
  rec {

    name = "codewithme-guest";
    version = "212.5457.46";
    src = fetchurl {
      url = "https://download.jetbrains.com/idea/code-with-me/CodeWithMeGuest-212.5457.46-no-jbr.tar.gz";
      sha256 = "0dflkj0rmc38q42y45r546ghb3ykqkmijb9ns6xg6sahn7indpwf";
    };
    wmClass = "jetbrains-idea";
    product = "CWM";
    extraLdPath = [ zlib ];
    meta = {
      homepage = "https://www.jetbrains.com/code-with-me/";
      description = "Thin client for Jetbrains remote collaboration solution - Code With Me";
      license = lib.licenses.unfree;
      longDescription = "";
      maintainers = with maintainers; [ remgodow ];
      platforms = [ "x86_64-darwin" "i686-darwin" "i686-linux" "x86_64-linux" ];
    };
    loName = "cwm_guest";
    hiName = "CWM";
    mainProgram = "cwm";
    vmoptsName = loName
      + (if (with stdenv.hostPlatform; (is32bit || isDarwin))
    then ""
    else "64")
      + ".vmoptions";

    desktopItem = makeDesktopItem {
      name = "CodeWithMe Thin Client";
      exec = "cwm";
      comment = lib.replaceChars [ "\n" ] [ " " ] meta.longDescription;
      desktopName = product;
      genericName = meta.description;
      categories = "Development;";
      icon = mainProgram;
      extraEntries = ''
        StartupWMClass=${wmClass}
      '';
    };

    vmoptsFile = lib.optionalString (vmopts != null) (writeText vmoptsName vmopts);

    nativeBuildInputs = [ makeWrapper patchelf unzip ];

    postPatch = lib.optionalString (!stdenv.isDarwin) ''
      get_file_size() {
        local fname="$1"
        echo $(ls -l $fname | cut -d ' ' -f5)
      }

      munge_size_hack() {
        local fname="$1"
        local size="$2"
        strip $fname
        truncate --size=$size $fname
      }

      interpreter=$(echo ${stdenv.glibc.out}/lib/ld-linux*.so.2)
      if [[ "${stdenv.hostPlatform.system}" == "x86_64-linux" && -e bin/fsnotifier64 ]]; then
        target_size=$(get_file_size bin/fsnotifier64)
        patchelf --set-interpreter "$interpreter" bin/fsnotifier64
        munge_size_hack bin/fsnotifier64 $target_size
      else
        target_size=$(get_file_size bin/fsnotifier)
        patchelf --set-interpreter "$interpreter" bin/fsnotifier
        munge_size_hack bin/fsnotifier $target_size
      fi
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/{bin,$name,share/pixmaps,libexec/${name}}
      cp -a . $out/$name
      ln -s $out/$name/bin/${loName}.png $out/share/pixmaps/${mainProgram}.png
      mv bin/fsnotifier* $out/libexec/${name}/.

      jdk=${jetbrains.jdk.home}
      item=${desktopItem}

      makeWrapper "$out/$name/bin/${loName}.sh" "$out/bin/${mainProgram}" \
        --prefix PATH : "${lib.optionalString (stdenv.isDarwin) "${jdk}/jdk/Contents/Home/bin:"}${lib.makeBinPath [ jetbrains.jdk coreutils gnugrep which git ]}" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath ([
          # Some internals want libstdc++.so.6
          stdenv.cc.cc.lib libsecret e2fsprogs
          libnotify
        ] ++ extraLdPath)}" \
        --set JDK_HOME "$jdk" \
        --set ${hiName}_JDK "$jdk" \
        --set ANDROID_JAVA_HOME "$jdk" \
        --set JAVA_HOME "$jdk" \
        --set ${hiName}_VM_OPTIONS ${vmoptsFile}

      ln -s "$item/share/applications" $out/share

      runHook postInstall
    '';

  } // lib.optionalAttrs (!(meta.license.free or true)) {
  preferLocalBuild = true;
}


