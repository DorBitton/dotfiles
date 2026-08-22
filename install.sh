#!/usr/bin/env bash
# ==============================================================================
# Sovereign 2026 Environment Installer for Ubuntu / Debian / WSL
# ==============================================================================
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_BIN="$HOME/.local/bin"
mkdir -p "$LOCAL_BIN" "$HOME/bin" "$HOME/go/bin" "$HOME/.config/alacritty" "$HOME/.config/nvim"

echo "============================================================"
echo " 🚀 Setting up Sovereign 2026 CLI Environment"
echo "============================================================"

# ------------------------------------------------------------------------------
# 1. Install System Packages via APT
# ------------------------------------------------------------------------------
if command -v apt-get &>/dev/null; then
    echo "📦 [1/6] Installing system packages via apt..."
    sudo apt-get update -y
    sudo apt-get install -y \
        curl wget git tmux neovim fzf ripgrep fd-find bat eza btop \
        xclip w3m w3m-img golang-go nodejs alacritty
fi

# Fix Debian/Ubuntu binary name aliases for bat and fd
[ -x /usr/bin/batcat ] && ln -sf /usr/bin/batcat "$LOCAL_BIN/bat"
[ -x /usr/bin/fdfind ] && ln -sf /usr/bin/fdfind "$LOCAL_BIN/fd"

# ------------------------------------------------------------------------------
# 2. Install Standalone CLI Tools (DevPod, Chezmoi, GitHub CLI)
# ------------------------------------------------------------------------------
echo "🛠️  [2/6] Installing CLI tools to $LOCAL_BIN..."

# chezmoi
if ! command -v chezmoi &>/dev/null && [ ! -f "$LOCAL_BIN/chezmoi" ]; then
    echo "  -> Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$LOCAL_BIN"
fi

# devpod
if ! command -v devpod &>/dev/null && [ ! -f "$LOCAL_BIN/devpod" ]; then
    echo "  -> Installing devpod..."
    curl -fsSL "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64" -o "$LOCAL_BIN/devpod"
    chmod +x "$LOCAL_BIN/devpod"
fi

# gh (GitHub CLI)
if ! command -v gh &>/dev/null && [ ! -f "$LOCAL_BIN/gh" ]; then
    echo "  -> Installing GitHub CLI (gh)..."
    GH_VER=$(curl -s "https://api.github.com/repos/cli/cli/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    if [ -n "$GH_VER" ]; then
        curl -fsSL "https://github.com/cli/cli/releases/download/v${GH_VER}/gh_${GH_VER}_linux_amd64.tar.gz" | tar -xz -C /tmp
        mv "/tmp/gh_${GH_VER}_linux_amd64/bin/gh" "$LOCAL_BIN/"
        rm -rf "/tmp/gh_${GH_VER}_linux_amd64"
    fi
fi

# btop (if not installed via apt)
if ! command -v btop &>/dev/null && [ ! -f "$LOCAL_BIN/btop" ]; then
    echo "  -> Installing btop..."
    BTOP_VER=$(curl -s "https://api.github.com/repos/aristocratos/btop/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    if [ -n "$BTOP_VER" ]; then
        curl -fsSL "https://github.com/aristocratos/btop/releases/download/v${BTOP_VER}/btop-x86_64-unknown-linux-musl.tar.gz" | tar -xz -C /tmp
        mv /tmp/btop/bin/btop "$LOCAL_BIN/"
        rm -rf /tmp/btop
    fi
fi

# ------------------------------------------------------------------------------
# 3. Configure DevPod Docker Provider
# ------------------------------------------------------------------------------
echo "🐳 [3/6] Configuring DevPod..."
if command -v devpod &>/dev/null || [ -f "$LOCAL_BIN/devpod" ]; then
    "$LOCAL_BIN/devpod" provider add docker 2>/dev/null || true
    "$LOCAL_BIN/devpod" provider use docker 2>/dev/null || true
fi

# ------------------------------------------------------------------------------
# 4. Link Dotfiles & Configurations
# ------------------------------------------------------------------------------
echo "🔗 [4/6] Linking configuration files..."

# Backup existing files if they are not symlinks
backup_if_exists() {
    local target="$1"
    if [ -f "$target" ] && [ ! -L "$target" ]; then
        mv "$target" "${target}.bak.$(date +%s)"
    fi
}

backup_if_exists "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"

backup_if_exists "$HOME/.bash_aliases"
ln -sf "$DOTFILES_DIR/bash/.bash_aliases" "$HOME/.bash_aliases"

backup_if_exists "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

backup_if_exists "$HOME/.config/alacritty/alacritty.toml"
ln -sf "$DOTFILES_DIR/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

# Link ask-ai
install -m 755 "$DOTFILES_DIR/bin/ask-ai" "$LOCAL_BIN/ask-ai"

# ------------------------------------------------------------------------------
# 5. Setup Neovim (LazyVim)
# ------------------------------------------------------------------------------
echo "📝 [5/6] Setting up Neovim & LazyVim..."
if [ ! -d "$HOME/.config/nvim/lua" ]; then
    cp -r "$DOTFILES_DIR/nvim/"* "$HOME/.config/nvim/" 2>/dev/null || true
fi

# ------------------------------------------------------------------------------
# 6. Default Shell Setup
# ------------------------------------------------------------------------------
echo "🐚 [6/6] Checking default login shell..."
if [ "$SHELL" != "/bin/bash" ] && command -v chsh &>/dev/null; then
    echo "  -> Setting default shell to /bin/bash (may prompt for password)..."
    chsh -s /bin/bash 2>/dev/null || echo "  -> Run 'chsh -s /bin/bash' to finish shell setup."
fi

echo "============================================================"
echo " ✅ Installation complete!"
echo " 💡 Reload shell with: source ~/.bashrc"
echo " 💡 Type 'help-all' to view available learning cheat sheets."
echo "============================================================"
