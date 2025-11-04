# My Neovim Configuration

This is my personal Neovim configuration, based on [LazyVim](https://github.com/LazyVim/LazyVim).

## Overview

This configuration is built upon the LazyVim distribution and customized with a set of plugins and settings to enhance the development workflow.

## Plugins

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) to manage plugins. Here is a list of the plugins included in this configuration:

### Core Plugins (from LazyVim)

* LazyVim
* blink.cmp 
* bufferline.nvim
* catppuccin 
* conform.nvim 
* crates.nvim 
* dial.nvim 
* flash.nvim
* friendly-snippets 
* gitsigns.nvim 
* grug-far.nvim 
* inc-rename.nvim 
* lazy.nvim
* lazydev.nvim 
* lualine.nvim
* mason-lspconfig.nvim 
* mason.nvim 
* mini.ai
* mini.hipatterns 
* mini.icons 
* mini.pairs
* noice.nvim
* nui.nvim
* nvim-lint
* nvim-lspconfig 
* nvim-treesitter
* nvim-treesitter-textobjects
* nvim-ts-autotag 
* persistence.nvim
* plenary.nvim
* rustaceanvim 
* snacks.nvim
* todo-comments.nvim
* tokyonight.nvim
* trouble.nvim
* ts-comments.nvim
* vim-dadbod 
* vim-dadbod-completion 
* vim-dadbod-ui 
* vim-helm 
* which-key.nvim
* yanky.nvim

 ### Custom Plugins and Configuration

The following customizations have been applied.

* Augment Code 

## How it Works

This configuration is loaded from `init.lua`, which bootstraps `lazy.nvim` and the rest of the configuration. The main configuration is in `lua/config/lazy.lua`, which sets up `lazy.nvim` and loads the plugins.

The plugins are defined in `lua/plugins/`. The file `lua/plugins/example.lua` contains the custom plugin configurations. Any file in this directory is automatically loaded by `lazy.nvim`.

The `lazy-lock.json` file is used to lock the versions of the plugins, ensuring that the configuration is reproducible.

## Installation

1.  Clone this repository to `~/.config/nvim`.
2.  Delete the .git folder
3.  Start Neovim. `lazy.nvim` will automatically install the plugins.
