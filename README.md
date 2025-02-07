# ren's NixOS+Hyprland dotfiles

![Screenshot-2024-01-17-13-15-14](https://redpengu.in/assets/images/nixdots.png)

|WM|Hyprland|
|---|-----|
|App Launcher|fuzzel|
|Menu bar|waybar|
|Notifications|dunst|
|Terminal|kitty|

## Custom application themes

- [Firefox (Firefox Colour link)](https://color.firefox.com/?theme=XQAAAAI5AQAAAAAAAABBKYhm849SCia3ftKEGccwS-xMDPr07qaHbYNzVWm9pdZWuSbUxoTOwv_PHaC7hs1paoxg9q2vdsZDln5DctMZmmL1UI1JbR4fWnRJS8bfXxdFI48Kct99Z2HeyLd4RKyMcqENeGj7h1bTVwywo7YctWkf0QG_by_q8A-fl6feqavHyJYnLkzilrKgKzMKf9sEkID6FBfsZ8XoItKsGlTc3EkRAUiRMj3DMHCo3kmkmI_BoStBv1TXG1x6g_8KQ4AA)
- Vencord (`themes/DarkBlueVencord.theme.css`)
- Obsidian Config (`themes/ObsidianConfig/`)
- all other applications use Catppuccin Macchiato

## Installing dots

You can install the entire setup onto your system with `sudo nixos-rebuild switch --fast --flake /path/to/root#pingu2`. If you just want the Hyprland dotfiles, you can find those in `modules/desktop`

To use the configs in the `rc` directory, follow the individual instructions for each file there
