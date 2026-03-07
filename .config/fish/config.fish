
# ███████╗██╗███████╗██╗  ██╗
# ██╔════╝██║██╔════╝██║  ██║
# █████╗  ██║███████╗███████║
# ██╔══╝  ██║╚════██║██╔══██║
# ██║     ██║███████║██║  ██║
# ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
# A smart and user-friendly command line
# https://fishshell.com

#######################################################################
#                            main settings                            #
#######################################################################

# Common paths
fish_add_path /usr/local/sbin
fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.yarn/bin
fish_add_path $HOME/.krew/bin
fish_add_path $HOME/.local/share/bob/nvim-bin

# OS specific paths
switch (uname)
    case Darwin
        fish_add_path /opt/homebrew/bin
        fish_add_path /opt/homebrew/sbin
        fish_add_path /opt/homebrew/opt/curl/bin
        fish_add_path /opt/homebrew/opt/ruby/bin
        fish_add_path /opt/homebrew/lib/ruby/gems/3.4.7/bin
        fish_add_path /opt/homebrew/opt/gawk/libexec/gnubin
        fish_add_path $HOME/Library/Python/3.11/bin

    case Linux
        if test -f /home/linuxbrew/.linuxbrew/bin/brew
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"
        end
end

# set default username to hide user@host ... see agnoster theme
set DEFAULT_USER steinbrueckri

# Fix issue with yetone/avante.nvim
set CURL_HTTP_VERSION 1.1

# XDG Directories
set -xg XDG_CONFIG_HOME $HOME/.config
set -xg XDG_CACHE_HOME $HOME/.cache

# show full path
set -U fish_prompt_pwd_dir_length 0

# color
export CLICOLOR=1
export LS_COLORS=(vivid generate rose-pine-moon)

# disable fish greeting
set fish_greeting

#######################################################################
#                                Brew                                #
#######################################################################

# Tell homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800

#######################################################################
#                             keybindings                             #
#######################################################################

bind \cf __fzf_reverse_isearch

#######################################################################
#                               plugins                               #
#######################################################################

fundle plugin sentriz/fish-pipenv
fundle plugin cuducos/dirvenv.fish
fundle init

#######################################################################
#                               aliases                               #
#######################################################################

# mac stuff
if string match -q "Darwin" (uname)
  alias sleepoff="sudo systemsetup -setcomputersleep Never"
  alias sleepon="sudo systemsetup -setcomputersleep 10"
  alias lock="pmset displaysleepnow"
  alias rm='trash '
  alias backup="caffeinate -i autorestic backup -l home"
  export GPG_TTY=$(tty)
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

# python stuff
alias newpyenv='uv venv .venv --python 3.12 && echo "{ \"venvPath\": \".\", \"venv\": \".venv\", \"include\": [\"src\", \"tests\"], \"exclude\": [\"**/__pycache__\", \".pytest_cache\", \".ruff_cache\", \".venv\"] }" > pyrightconfig.json && mkdir -p src tests && source .venv/bin/activate.fish'
alias activate_env_datacenter="source ~/Userlike/UserlikeDatacenter/.venv/bin/activate.fish"
alias activate_env_code="source ~/Userlike/Userlike/.venv/bin/activate.fish"

## digitalocean stuff
alias do='doctl'
alias do-new='doctl compute droplet create tmp --region ams3 --size s-2vcpu-2gb --image ubuntu-22-04-x64 --user-data-file .dotfileassets/digitalocean-cloudinit.yaml --ssh-keys "df:17:95:8d:31:56:39:27:d1:04:e3:12:52:36:ed:5b"'
alias do-new-ssh='ssh $(doctl compute droplet list | grep tmp | awk "{ print $3}")'

## docker
alias dr="docker run -it --rm --entrypoint /bin/sh"
alias rm-images="docker rmi (docker images -q)"

## Teleport
alias tssh="tsh ssh (tsh ls | tail --lines=+3 | fzf -e | head -n 1 | cut -d ' ' -f1)"

## Misc
alias pwgen="date +%s | sha256sum | base64 | head -c 32 ; echo"
alias cat="bat "
alias hosts="hosts --auto-sudo"
alias ls='eza --icons'
alias top='btop'
alias watch='viddy'
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
#                               exports                               #
#######################################################################

# general
export EDITOR=nvim
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# gpg
export GPG_TTY=$(tty)

# kubernetes stuff
export KUBE_EDITOR="nvim"
export PATH="$PATH:$HOME/.krew/bin"

# rust stuff
export PATH="$HOME/.cargo/bin:$PATH"

# gcloud stuff
export CLOUDSDK_PYTHON_SITEPACKAGES=1 # pynum is installed

# -> Starting in kubectl v1.25, this plugin will be required for authentication.
# -> https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# ansible stuff
# export ANSIBLE_VAULT_PASSWORD_FILE="~/.vault-password-file"
export PY_COLOR=1
export ANSIBLE_FORCE_COLOR=1

# Source: https://github.com/ansible/ansible/issues/32499
# This is apparently due to some new security changes made in High Sierra that are breaking lots of Python things that use fork(). Rumor has it that adding
# export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES before your Ansible run should clear it up. The code that's causing issues is well below Ansible in the stack.
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Teleport disable adding keys to the agent
# https://github.com/gravitational/teleport/issues/22326
export TELEPORT_ADD_KEYS_TO_AGENT=no

################################################################################
# ssh-agent magic
################################################################################
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
            echo "Socket $SSH_AUTH_SOCK is dead!  Deleting!"
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
    # ssh agent sockets can be attached to a ssh daemon process or an
    # ssh-agent process.

    set -l AGENTFOUND 0

    # Attempt to find and use the ssh-agent in the current environment
    if sshagent_testsocket ;
        set AGENTFOUND 1
    end

    # If there is no agent in the environment, search /tmp for
    # possible agents to reuse before starting a fresh ssh-agent
    # process.
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

    # If at this point we still haven't located an agent, it's time to
    # start a new one
    if [ $AGENTFOUND = 0 ] ;
      echo need to start a new agent
      eval (ssh-agent -c)
    end

    # Finally, show what keys are currently in the agent
    # ssh-add -l
end

#######################################################################
#                              functions                              #
#######################################################################

function cheat
    if test (count $argv) -eq 0
        echo "Usage: cheat <command>"
        return 1
    end
    curl -s "https://cht.sh/$argv"
end

# Check if we are in a container
if not test -e /.dockerenv
  set ssh_agent_sock ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
  # check if 1password socket exist
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

# Start ssh-agent, load key from 1password and added to the ssh-agent
function loadsshkey
  eval $(op signin --account pixel-combo.1password.com)
  op item get xo5tj3nxex65km7gdj5r4algni --fields=Private-Key --reveal | sed 's/\"//g' | sed '$d' | sed '1,1d' | ssh-add -
end


#######################################################################
#                               source                                #
#######################################################################
set gcloud "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
if test -e $gcloud
  source $gcloud
end

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

# Load sesh
if command -v sesh >/dev/null
    sesh completion fish | source
end

# Load s3cr3ts

if test -f  $HOME/.config/fish/s3cr3ts.fish
    source $HOME/.config/fish/s3cr3ts.fish
end

#######################################################################
#                                tmux                                 #
#######################################################################

# set -gx SESH_DEFAULT default
# # Auto-attach/switch to existing session (or create it)
# if type -q sesh
#     if tmux has-session -t $SESH_DEFAULT 2>/dev/null
#         if not set -q TMUX
#             tmux attach-session -t $SESH_DEFAULT
#         else
#             tmux switch-client -t $SESH_DEFAULT
#         end
#     else
#         # Create the session (detached)
#         tmux new-session -d -s $SESH_DEFAULT -c $HOME
#
#         if not set -q TMUX
#             tmux attach-session -t $SESH_DEFAULT
#         else
#             tmux switch-client -t $SESH_DEFAULT
#         end
#     end
# end
