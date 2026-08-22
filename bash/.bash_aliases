# ==============================================================================
# Sovereign Bash Aliases & Learning Helpers
# ==============================================================================

# Directory listing & Navigation
if command -v eza &>/dev/null; then
    alias ls='eza --icons=auto --group-directories-first'
    alias ll='eza -lh --icons=auto --group-directories-first --git'
    alias la='eza -lah --icons=auto --group-directories-first --git'
    alias lt='eza --tree --level=2 --icons=auto'
else
    alias ls='ls --color=auto'
    alias ll='ls -lh --color=auto'
    alias la='ls -lah --color=auto'
fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Quick Utilities
alias grep='grep --color=auto'
alias df='df -h'
alias free='free -h'
alias btop='btop'
alias cls='clear'
alias ports='ss -tulpn'
alias myip='curl -s https://ifconfig.me && echo'

# Git shortcuts
alias gs='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias glog='git log --oneline --graph --decorate -n 15'

# Tmux shortcuts
alias t='tmux attach || tmux new-session'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'

# AI Aliases (using Google Antigravity / Gemini)
alias '??'='ask-ai'
alias ai='ask-ai'
alias ask='ask-ai'

# ==============================================================================
# Disposable Container Sandbox Helper
# ==============================================================================
sandbox() {
    local img="${1:-ubuntu:latest}"
    echo "🚀 Starting disposable sandbox: $img"
    echo "💡 Note: This is 100% isolated. Type 'exit' to destroy container."
    docker run --rm -it -v "$PWD":/workspace -w /workspace "$img" bash 2>/dev/null || \
    docker run --rm -it -v "$PWD":/workspace -w /workspace "$img" sh
}

# ==============================================================================
# Learning Cheat Sheets
# ==============================================================================

help-all() {
    cat << 'ALL_EOF'
================================================================================
                    AVAILABLE LEARNING CHEAT SHEETS
================================================================================
  help-vim        -> Vim & Neovim survival guide (modes, saving, navigation)
  help-tmux       -> Tmux keybindings (splits, navigation, windows, copy mode)
  help-containers -> Docker sandboxes & DevPod isolated development guide
  help-pe         -> Bash Parameter Expansion reference (${VAR:-def}, etc.)
================================================================================
ALL_EOF
}
alias help-menu='help-all'
alias help-me='help-all'

help-containers() {
    cat << 'CONTAINER_EOF'
================================================================================
            CONTAINERS & DEVPOD GUIDE (ISOLATED WORKSPACES)
================================================================================
1. INSTANT DISPOSABLE SANDBOXES (Practice without installing on PC):
   sandbox                  -> Instant clean Ubuntu Linux sandbox
   sandbox python:3.12      -> Instant Python 3.12 playground
   sandbox node:22          -> Instant Node.js playground
   sandbox golang:latest    -> Instant Go environment
   sandbox alpine:latest    -> Ultra-lightweight (5MB) Linux shell
   * Note: Everything is mounted to /workspace. Type 'exit' to wipe clean!

2. RAW DOCKER COMMANDS:
   docker run --rm -it ubuntu bash   -> Run one-off disposable container
   docker ps                         -> List running containers
   docker images                     -> List downloaded images
   docker logs <id>                  -> View container logs

3. DEVPOD (Full Project Development in Containers):
   devpod up .                       -> Start workspace defined in .devcontainer
   devpod list                       -> List all active DevPod workspaces
   devpod ssh <name>                 -> Open SSH terminal into dev container
   devpod stop .                     -> Pause current dev workspace
   devpod delete .                   -> Delete dev container completely

4. BASIC .devcontainer/devcontainer.json TEMPLATE:
   {
     "name": "DevOps Sandbox",
     "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
     "features": {
       "ghcr.io/devcontainers/features/docker-in-docker:2": {}
     }
   }
================================================================================
CONTAINER_EOF
}
alias help-docker='help-containers'
alias help-devpod='help-containers'
alias help-sandbox='help-containers'

help-vim() {
    cat << 'VIM_EOF'
================================================================================
                    VIM / NEOVIM SURVIVAL GUIDE (WEEK 1)
================================================================================
* Note: All keybindings here work identically in both Vim and Neovim!

1. THE GOLDEN RULE (Modes):
   - Vim starts in NORMAL mode (for navigating and commands, not typing text).
   - Press 'i' to enter INSERT mode (to type text).
   - Press 'Esc' to return to NORMAL mode (when done typing).
   - Always press 'Esc' if you ever get lost or confused!

2. HOW TO SAVE & QUIT (From NORMAL mode, press Esc first):
   :w            -> Save (write) changes
   :q            -> Quit (closes editor)
   :wq           -> Save and quit
   :q!           -> Force quit without saving (throw away mistakes)

3. MOVING AROUND (In NORMAL mode):
   h             -> Left
   j             -> Down
   k             -> Up
   l             -> Right
   w             -> Jump forward to start of next word
   b             -> Jump backward to start of previous word
   0             -> Jump to start of line
   $             -> Jump to end of line
   gg            -> Jump to very top of file
   G             -> Jump to very bottom of file
   :12           -> Jump to line 12

4. EDITING & FIXING (In NORMAL mode):
   u             -> Undo last action
   Ctrl-r        -> Redo
   x             -> Delete (cut) character under cursor
   dd            -> Delete (cut) entire line
   yy            -> Copy (yank) entire line
   p             -> Paste below current line
   o             -> Insert new line below and switch to typing
   O             -> Insert new line above and switch to typing

5. SEARCHING:
   /text         -> Search forward for "text" (press Enter)
   n             -> Jump to NEXT match
   N             -> Jump to PREVIOUS match

💡 PRO TIP: Run 'nvim +Tutor' in your terminal for a 15-minute hands-on interactive game!
================================================================================
VIM_EOF
}

help-tmux() {
    cat << 'TMUX_EOF'
================================================================================
                    TMUX DEFAULT KEYBINDINGS (Prefix: Ctrl-b)
================================================================================
Panes & Splits:
  Ctrl-b %      : Split pane Vertically (left / right)
  Ctrl-b "      : Split pane Horizontally (top / bottom)
  Ctrl-b <arrow>: Move focus between panes
  Ctrl-b h/j/k/l: Move focus (Vi navigation)
  Ctrl-b z      : Toggle Zoom (maximize/minimize active pane)
  Ctrl-b x      : Kill active pane

Windows (Tabs):
  Ctrl-b c      : Create new window
  Ctrl-b 1..9   : Jump directly to window N
  Ctrl-b n / p  : Next / Previous window
  Ctrl-b ,      : Rename current window
  Ctrl-b w      : Interactive window/session switcher list

Sessions & Clipboard:
  Ctrl-b d      : Detach from current session (reconnect with 'tmux attach')
  Ctrl-b [      : Enter Copy mode (press 'v' to select, 'y' to yank to OS clipboard)
  Ctrl-b P      : Paste buffer
  Ctrl-b s      : Interactive session list
================================================================================
TMUX_EOF
}

help-pe() {
    cat << 'PE_EOF'
================================================================================
                    BASH PARAMETER EXPANSION CHEAT SHEET
================================================================================
1. Default Values:
   ${VAR:-default}   -> If VAR is unset/null, use 'default' (VAR remains unchanged)
   ${VAR:=default}   -> If VAR is unset/null, set VAR to 'default' and return it
   ${VAR:?error}     -> If VAR is unset/null, exit script and print 'error'

2. Substring & Length:
   ${#VAR}           -> Length of $VAR in characters
   ${VAR:offset:len} -> Substring starting at 'offset' for 'len' characters

3. Pattern Stripping:
   ${VAR#pattern}    -> Remove shortest match from START (prefix)
   ${VAR##pattern}   -> Remove longest match from START (prefix)
   ${VAR%pattern}    -> Remove shortest match from END (suffix)
   ${VAR%%pattern}   -> Remove longest match from END (suffix)
   Example: FILE="archive.tar.gz" -> ${FILE%.tar.gz} => "archive"

4. Search & Replace:
   ${VAR/pattern/replace}  -> Replace first match
   ${VAR//pattern/replace} -> Replace all matches

5. Case Modification:
   ${VAR^^}          -> Convert to UPPERCASE
   ${VAR,,}          -> Convert to lowercase
================================================================================
PE_EOF
}

# Antigravity CLI with auto-approved tool permissions
alias agy-y='agy --dangerously-skip-permissions'
alias agya='agy --dangerously-skip-permissions'
