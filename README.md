## Homedir skeleton

Contains the various rc files, other conf files, and ~/bin/ scripts that make up my homefolder.

There are multiple skeletons:

| skel dir   | designed for      |
| ---------- | ----------------- |
| base       | any system        |
| graphical  | graphical systems |
| local-$X   | system $X         |

In addition, a installer script is provided:

`./install [--symlink | --hardlink] [--to-etc-skel] skeldir [skeldir ...]`

 - All files in skeldir are installed in the specified mode (copy/symlink/hardlink).
 - All required folders are created, not linked.
 - skeldir __must__ not contain anything but plain files and directories.
 - There is no `uninstall` command.

Feel free to fork this repo and use it for your own skel.
