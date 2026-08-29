# ~/.bashrc - Sovereign 2026 Environment for Dor
# Focus: Performance, Learning, Bash Fundamentals, Distraction-Free

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ------------------------------------------------------------------------------
# History Configuration
# ------------------------------------------------------------------------------
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=50000
HISTFILESIZE=100000
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar 2>/dev/null

# ------------------------------------------------------------------------------
# PATH & Go Setup
# ------------------------------------------------------------------------------
export GOPATH="$HOME/go"
export PATH="$HOME/.local/bin:$HOME/bin:$HOME/go/bin:$PATH"

# ------------------------------------------------------------------------------
# Programmable Completion
# ------------------------------------------------------------------------------
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ------------------------------------------------------------------------------
# Git-Aware Prompt (Fast, zero external dependencies)
# ------------------------------------------------------------------------------
parse_git_branch() {
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        echo -e "\001\033[38;5;214m\002($branch)\001\033[00m\002 "
    fi
}

# Color palette: Catppuccin / Minimal Dark
PS1='\[\033[01;34m\]\w\[\033[00m\] $(parse_git_branch)❯ '

# ------------------------------------------------------------------------------
# Source Aliases & Helpers
# ------------------------------------------------------------------------------
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ------------------------------------------------------------------------------
# Tool Integrations
# ------------------------------------------------------------------------------
# FZF (Fuzzy Finder) keybindings & completion
if command -v fzf &>/dev/null; then
    eval "$(fzf --bash 2>/dev/null || true)"
fi

# Default Editor
export EDITOR="nvim"
export VISUAL="nvim"
