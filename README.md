# dotfiles

## Packages

Save list of installed packages:

```sh
pacman -Qqe > packages.txt
```

Install package list

```sh
yay -S --needed - < packages.txt
```

