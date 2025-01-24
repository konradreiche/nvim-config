# Neovim Configuration 📜

This repository contains my personal Neovim configuration files.

![Screenshot](./screenshot.png)

## Setup

1. Clone this repository to your Neovim configuration directory:
   ```bash
   git clone https://github.com/konradreiche/nvim-config.git ~/.config/nvim
   ```
2. Install [vim-plug](https://github.com/junegunn/vim-plug) if not already installed.
3. Launch Neovim and install plugins:
   ```vim
   :PlugInstall
   ```

## Vim Command Tips

* After using `vim.lsp.buf.rename()`, run `:wa` to save all open files at once. Use `:ls` to check modified files before saving if needed.
