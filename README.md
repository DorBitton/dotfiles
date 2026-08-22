# Sovereign 2026 CLI Dotfiles

A minimalist, high-efficiency, distraction-free Linux/WSL environment built around **Bash**, **Tmux**, **Neovim (LazyVim)**, **Dev Containers**, and **AI Unix pipelines**.

---

## 🚀 Quick Install on a Fresh Machine

On any fresh Ubuntu / Debian / WSL machine, simply run:

```bash
git clone git@github.com:DorBitton/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Then reload your shell:
```bash
source ~/.bashrc
```

---

## 📦 What It Installs & Configures

| Component | Tool / Setting | Description |
| :--- | :--- | :--- |
| **Shell** | **Bash (`/bin/bash`)** | Clean POSIX-first shell, fast git-branch prompt, smart history |
| **Multiplexer** | **Tmux 3.6** | Default `Ctrl-b` prefix, 1-based indexing, top status bar, OS clipboard sync |
| **Terminal** | **Alacritty** | GPU-accelerated, Catppuccin Mocha theme, zero latency |
| **Editor** | **LazyVim (Neovim)** | Modular Neovim setup with LSP, treesitter, formatting |
| **Dev Containers**| **DevPod + Docker** | Isolated development environments (`devpod up .` and `sandbox`) |
| **AI CLI** | **Google Antigravity (`agy`)** | Unix-piped Gemini 3.7 Flash queries (`?? "question"`) |
| **Language** | **Go 1.26** | `$GOPATH` and `~/go/bin` in `$PATH` |
| **Utilities** | `btop`, `fzf`, `rg`, `fd`, `bat`, `eza`, `w3m`, `chezmoi`, `gh` | Modern CLI productivity suite |

---

## 📖 Built-in Learning Cheatsheets

Run these commands directly in your terminal at any time:

* `help-all` : Overview of all available cheat sheets
* `help-vim` : Week 1 Vim & Neovim survival guide (modes, saving, moving, editing)
* `help-tmux` : Default Tmux keybindings, splits, and session commands
* `help-containers` : Disposable Docker sandboxes and DevPod guide
* `help-pe` : Bash Parameter Expansion reference (`${VAR:-default}`, pattern stripping, etc.)

---

## 🛠️ Quick Daily Commands

```bash
t                   # Attach to existing Tmux session or start a new one
?? "how to sort"    # Ask Gemini directly from terminal
sandbox             # Launch instant disposable Ubuntu sandbox
sandbox python:3.12 # Launch instant Python sandbox
sandbox golang      # Launch instant Go sandbox
btop                # Launch hardware & process monitor
```
