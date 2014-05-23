## Homedir skeleton

Contains the various rc files, other conf files, and ~/bin/ scripts that make up my homefolder.

There are multiple skeletons:

| skel dir   | designed for      |
| ---------- | ----------------- |
| base       | any system        |
| graphical  | graphical systems |
| local-$X   | system $X         |

In addition, an installer script is provided.

    usage: install [-h]
                   [--symlink | --hardlink | --remote USER@HOST | --target TARGETDIR]
                   [--force-unchanged] [--backup FILE.tar] [--simulate]
                   [--exclude REGEX]
                   skeldir [skeldir ...]

 - All files from skeldir are installed in the specified mode (copy/symlink/hardlink).
 - Regardless, all folders are created, not linked.
 - `--remote` allows installation to a remote ssh host.
 - similarily, `--target` allows installation to a different folder.
 - There is no `--uninstall` command, but `--backup` will save the old config.
 - install will ask for confirmation, and allows `--simulate` that won't do any write access.

Two example typescripts of `./install` invocations can be viewed by typing

    curl http://pub.sft.mx/skelinstalltypescript0
    curl http://pub.sft.mx/skelinstalltypescript1

Feel free to fork this repo and use it for your own rc files.
