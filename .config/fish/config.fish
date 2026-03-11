# ███████╗██╗███████╗██╗  ██╗
# ██╔════╝██║██╔════╝██║  ██║
# █████╗  ██║███████╗███████║
# ██╔══╝  ██║╚════██║██╔══██║
# ██║     ██║███████║██║  ██║
# ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
# A smart and user-friendly command line
# https://fishshell.com

#######################################################################
#                             Main Settings                           #
#######################################################################

# Set default theme
set THEME rose-pine-dawn

# Set default username to hide user@host
set DEFAULT_USER steinbrueckri

# XDG directories
set -xg XDG_CONFIG_HOME $HOME/.config
set -xg XDG_CACHE_HOME $HOME/.cache

# Show full path in prompt
set -U fish_prompt_pwd_dir_length 0

# Disable fish greeting
set fish_greeting

#######################################################################
#                                 Path                                #
#######################################################################

fish_add_path /usr/local/sbin
fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.yarn/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/share/bob/nvim-bin

#######################################################################
#                               Homebrew                              #
#######################################################################

# Prevent Homebrew from auto-updating on every command (once per week)
set -gx HOMEBREW_AUTO_UPDATE_SECS 604800

# Detect Homebrew installation path (macOS / Linux)
for brew_path in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew
    if test -x $brew_path
        eval ($brew_path shellenv)
        break
    end
end

#######################################################################
#                              LS_COLORS                              #
#######################################################################

set -gx CLICOLOR 1

switch $THEME
    case rose-pine-dawn
        set -gx LS_COLORS $rose_pine_dawn
    case rose-pine-moon
        set -gx LS_COLORS $rose_pine_moon
end

#######################################################################
#                                  FZF                                #
#######################################################################
# Source: https://github.com/rose-pine/fzf
#######################################################################

switch $THEME
    case rose-pine-dawn
        set -gx FZF_DEFAULT_OPTS "
            --color=fg:#797593,bg:#faf4ed,hl:#d7827e
            --color=fg+:#575279,bg+:#f2e9e1,hl+:#d7827e
            --color=border:#dfdad9,header:#286983,gutter:#faf4ed
            --color=spinner:#ea9d34,info:#56949f
            --color=pointer:#907aa9,marker:#b4637a,prompt:#797593"
    case rose-pine-moon
        set -gx FZF_DEFAULT_OPTS "
            --color=fg:#908caa,bg:#232136,hl:#ea9a97
            --color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
            --color=border:#44415a,header:#3e8fb0,gutter:#232136
            --color=spinner:#f6c177,info:#9ccfd8
            --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
end

#######################################################################
#                              Keybindings                            #
#######################################################################

bind \cf __fzf_reverse_isearch

#######################################################################
#                                Plugins                              #
#######################################################################

fundle plugin sentriz/fish-pipenv
fundle plugin cuducos/dirvenv.fish
fundle init

#######################################################################
#                                Aliases                              #
#######################################################################

# macOS
if test -d /Applications
    alias sleepoff="sudo systemsetup -setcomputersleep Never"
    alias sleepon="sudo systemsetup -setcomputersleep 10"
    alias lock="pmset displaysleepnow"
    alias rm="trash "
    alias backup="caffeinate -i autorestic backup -l home"
end

# vim 4 the win!
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias n="nvim"
alias nvim-switch-nightly="bob use nightly"
alias nvim-switch-stable="bob use stable"

# tmux / sesh
alias ss="sesh picker -i"

# lazygit / git
alias lg="lazygit"
alias lgd="lazydot"
alias lazydot="lazygit -ucd ~/.local/share/yadm/lazygit -w ~ -g ~/.local/share/yadm/repo.git"
alias lol="git log --pretty=oneline --abbrev-commit --graph --decorate"
alias gp="git pull"

# Python
alias newpyenv='uv venv .venv --python 3.12 && echo "{ \"venvPath\": \".\", \"venv\": \".venv\", \"include\": [\"src\", \"tests\"], \"exclude\": [\"**/__pycache__\", \".pytest_cache\", \".ruff_cache\", \".venv\"] }" > pyrightconfig.json && mkdir -p src tests && source .venv/bin/activate.fish'
alias activate_env_datacenter="source ~/Userlike/UserlikeDatacenter/.venv/bin/activate.fish"
alias activate_env_code="source ~/Userlike/Userlike/.venv/bin/activate.fish"

# Docker
alias dr="docker run -it --rm --entrypoint /bin/sh"
alias rm-images="docker rmi (docker images -q)"

# Teleport
alias tssh="tsh ssh (tsh ls | tail --lines=+3 | fzf -e | head -n 1 | cut -d ' ' -f1)"

# Misc
alias pwgen="date +%s | sha256sum | base64 | head -c 32 ; echo"
alias cat="bat "
alias hosts="hosts --auto-sudo"
alias ls="eza --icons"
alias top="btop"
alias watch="viddy"
alias myip='curl -s -H "Accept: application/json" ipinfo.io | jq -r .ip'
alias ag="rg"
alias sslcheck="nmap --script ssl-cert -p 443"
alias sslyze="docker run --rm -it nablac0d3/sslyze:latest"
alias lightmode="themr rose-pine-dawn"
alias darkmode="themr rose-pine-moon"
alias kill-ansible-ssh='ps aux | grep "ansible-" | grep "\[mux\]" | awk "{print \$2}" | xargs kill -9'
alias mail="aerc"
alias news="newsboat"

#######################################################################
#                                Exports                              #
#######################################################################

# General
set -gx EDITOR nvim
set -gx LANG "en_US.UTF-8"
set -gx LC_ALL "en_US.UTF-8"
set -gx LC_CTYPE "en_US.UTF-8"

# GPG
set -gx GPG_TTY (tty)

# Ansible
set -gx PY_COLOR 1
set -gx ANSIBLE_FORCE_COLOR 1

# Source: https://github.com/ansible/ansible/issues/32499
# This is apparently due to some new security changes made in High Sierra that are breaking lots of Python things that use fork(). Rumor has it that adding
# set -gx OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES before your Ansible run should clear it up. The code that's causing issues is well below Ansible in the stack.
set -gx OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES

# Teleport: disable adding keys to the agent
# https://github.com/gravitational/teleport/issues/22326
set -gx TELEPORT_ADD_KEYS_TO_AGENT no

# Disable mise, see /opt/homebrew/share/fish/vendor_conf.d/mise-activate.fish
set -gx MISE_FISH_AUTO_ACTIVATE 0


#######################################################################
#                               Functions                             #
#######################################################################

function sshagent_findsockets
    find /tmp -uid (id -u) -type s -name agent.\* 2>/dev/null
end

function sshagent_testsocket
    if [ ! -x (command which ssh-add) ] ;
        echo "ssh-add is not available; agent testing aborted"
        return 1
    end

    if [ X"$argv[1]" != X ] ;
    	set -xg SSH_AUTH_SOCK $argv[1]
    end

    if [ X"$SSH_AUTH_SOCK" = X ]
        return 2
    end

    if [ -S $SSH_AUTH_SOCK ] ;
        ssh-add -l > /dev/null
        if [ $status = 2 ] ;
            echo "Socket $SSH_AUTH_SOCK is dead! Deleting!"
            rm -f $SSH_AUTH_SOCK
            return 4
        else ;
            echo "Found ssh-agent $SSH_AUTH_SOCK"
            return 0
        end
    else ;
        echo "$SSH_AUTH_SOCK is not a socket!"
        return 3
    end
end

function ssh_agent_init
    # ssh-agent sockets can be attached to a ssh daemon process
    # or an ssh-agent process.
    set -l AGENTFOUND 0

    # Try current environment first
    if sshagent_testsocket ;
        set AGENTFOUND 1
    end

    # Search /tmp for reusable agents before starting a new one
    if [ $AGENTFOUND = 0 ];
        for agentsocket in (sshagent_findsockets)
            if [ $AGENTFOUND != 0 ] ;
                break
            end

            if sshagent_testsocket $agentsocket ;
                set AGENTFOUND 1
            end
        end
    end

    # Start a new agent if none was found
    if [ $AGENTFOUND = 0 ] ;
        echo need to start a new agent
        eval (ssh-agent -c)
    end
end

# Start ssh-agent, load key from 1password and add it to ssh-agent
function loadsshkey
    eval $(op signin --account pixel-combo.1password.com)
    op item get xo5tj3nxex65km7gdj5r4algni --fields=Private-Key --reveal | sed 's/\"//g' | sed '$d' | sed '1,1d' | ssh-add -
end

#######################################################################
#                                 Source                              #
#######################################################################

set op "~/.config/op/plugins.sh"
if test -e $op
    source $op
end

# Load try
if command -v try >/dev/null
    eval (try init ~/tmp/tries | string collect)
end

# Load direnv
if command -v direnv >/dev/null
    direnv hook fish | source
end

# Load atuin
if command -v atuin >/dev/null
    atuin init fish --disable-up-arrow | source
end

# Load starship prompt
if command -v starship >/dev/null
    starship init fish | source
end

# Load zoxide
if command -v zoxide >/dev/null
    zoxide init fish | source
end

# Load s3cr3ts
if test -f $HOME/.config/fish/s3cr3ts.fish
    source $HOME/.config/fish/s3cr3ts.fish
end

#######################################################################
#                                  Main                               #
#######################################################################

# Auto attach to tmux session if not already attached
if status is-interactive
    if type -q tmux
        if not set -q TMUX
            exec tmux new-session -A -s "default" -c "$HOME"
        end
    end
end

# load ssh-agent 
# Check if we are in a container
if not test -e /.dockerenv
    set ssh_agent_sock ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

    # Check if 1Password socket exists
    if test -e $ssh_agent_sock
        set -xg SSH_AUTH_SOCK $ssh_agent_sock
    else
        echo "1password ssh agent.sock not found, start ssh-agent"
        echo "Please load your ssh key with the command loadsshkey!"
        ssh_agent_init
    end
else
    echo "Running inside a Docker container, skipping SSH agent setup."
end