# dotfiles

## Packages

Two package lists are included:

- `packages.core.txt` (packages I need day to day)
- `packages.optional.txt` (packages I need now and then)

Get list of installed packages:

```sh
pacman -Qqe
```

Install package list:

```sh
yay -S --needed - < packages.core.txt
yay -S --needed - < packages.optional.txt
```

