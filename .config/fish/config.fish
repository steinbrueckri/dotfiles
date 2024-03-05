
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

fish_add_path /usr/local/sbin
fish_add_path $HOME/bin
fish_add_path $HOME/.cargo/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/opt/ruby/bin
fish_add_path $HOME/.local/share/bob/nvim-bin
fish_add_path $HOME/Library/Python/3.11/bin

# set default username to hide user@host ... see agnoster theme
set DEFAULT_USER steinbrueckri

# show full path
set -U fish_prompt_pwd_dir_length 0

# theme
set theme_color_scheme "dracula"

# color
export CLICOLOR=1
export LS_COLORS=(vivid generate dracula)

# fzf theme
set -Ux FZF_DEFAULT_OPTS "\
  --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9
  --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9
  --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6
  --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

# disable fish greeting
set fish_greeting

# disable default keybindings from jethrokuan/fzf
set -U FZF_DISABLE_KEYBINDINGS 1

#######################################################################
#                             keybindings                             #
#######################################################################

bind \cf __fzf_reverse_isearch

#######################################################################
#                               plugins                               #
#######################################################################

fundle plugin oh-my-fish/theme-bobthefish
fundle plugin jethrokuan/fzf
fundle plugin jorgebucaran/nvm.fish
fundle plugin sentriz/fish-pipenv
fundle init

#######################################################################
#                               prompt                                #
#######################################################################

set -g theme_display_virtualenv no
set -g theme_git_worktree_support no
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g theme_display_user ssh
set -g theme_display_hostname ssh
set -g theme_display_git_default_branch yes
set -g theme_title_use_abbreviated_path no
set -g theme_display_git_dirty_verbose yes
set -g theme_display_k8s_context no
set -g theme_display_k8s_namespace no
set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_display_date no
set -g theme_newline_cursor yes
set -g theme_newline_prompt '$ '

#######################################################################
#                               aliases                               #
#######################################################################

# mac stuff
if string match -q "Darwin" (uname)
  alias sleepoff="sudo systemsetup -setcomputersleep Never"
  alias sleepon="sudo systemsetup -setcomputersleep 10"
  alias lock="pmset displaysleepnow"
  alias rm='trash '
  export GPG_TTY=$(tty)
end

# vim 4 the win!
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias n="nvim"
alias nvim-switch-nightly="bob use nightly"
alias nvim-switch-stable="bob use stable"

# lazygit
alias lg="lazygit"
alias ld="lazygit -ucd ~/.local/share/yadm/lazygit -w ~ -g ~/.local/share/yadm/repo.git"

# kubernetes stuff
alias kx="kubectx"
alias k="kubectl"
alias kc="kubecolor"
alias kn='kubens'
alias k-debug="kubectl run --namespace default -i --tty 'debug-default-$USER' --image=steinbrueckri/debug --restart=Never --rm=true -- bash"
alias k-debug-app="kubectl run --namespace istio-apps -i --tty 'debug-$USER' --image=steinbrueckri/debug --restart=Never --rm=true -- bash"

# python stuff
alias newpyenv="PIPENV_VENV_IN_PROJECT=1 pipenv --python 3.11 && echo '{ \"venvPath\": \".\", \"venv\": \".venv\" }' > pyrightconfig.json && source .venv/bin/activate.fish"
alias activate_env_datacenter="source ~/Userlike/UserlikeDatacenter/.venv/bin/activate.fish"
alias activate_env_code="source ~/Userlike/Userlike/.venv/bin/activate.fish"

## goole cloud stuff
alias gcpil='gcloud compute instances list'
alias gcpal='gcloud compute addresses list'
alias gcpssh='gcloud compute ssh'
alias gcpsshi='gcloud compute ssh --internal-ip'
alias gcpsshiap='gcloud compute ssh --tunnel-through-iap'
alias gcprdpiap='gcloud compute start-iap-tunnel $1 3389 --local-host-port=localhost:3389 --zone=$2'

## digitalocean stuff
alias do='doctl'
alias do-new='doctl compute droplet create tmp --region ams3 --size s-2vcpu-2gb --image ubuntu-22-04-x64 --user-data-file .dotfileassets/digitalocean-cloudinit.yaml --ssh-keys "df:17:95:8d:31:56:39:27:d1:04:e3:12:52:36:ed:5b"'
alias do-new-ssh='ssh $(doctl compute droplet list | grep tmp | awk "{ print $3}")'

## multipass
alias localvm='multipass launch -c 4 -m 4G -d 50G -n localvm 20.04 --cloud-init .dotfileassets/multipass-common.yaml'

## docker
alias dr="docker run -it --rm --entrypoint /bin/sh"
alias rm-images="docker rmi (docker images -q)"

## Misc
alias pwgen="date +%s | sha256sum | base64 | head -c 32 ; echo"
alias lol="git log --pretty=oneline --abbrev-commit --graph --decorate"
alias cat="bat "
alias hosts="hosts --auto-sudo"
alias ls='eza --icons'
alias top='btop'
alias watch='viddy'
alias myip='curl -s -H "Accept: application/json" ipinfo.io | jq -r .ip'

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

set ssh_agent_sock ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
if test -e $ssh_agent_sock
  set -xg SSH_AUTH_SOCK $ssh_agent_sock
else
  echo "1password ssh agent.sock not found, start ssh-agent"
  echo "Please load your ssh key with the command loadsshkey!"
  ssh_agent_init
end

# Start ssh-agent, load key from 1password and added to the ssh-agent
function loadsshkey
  eval $(op signin --account pixel-combo.1password.com)
  op item get xo5tj3nxex65km7gdj5r4algni --fields=Private-Key --reveal | sed 's/\"//g' | sed '$d' | sed '1,1d' | ssh-add -
end

function gcp-project
    set FILE "$HOME/.gcp-project-list.json"
    # TODO: only if the file is older then 1d or if --force is set
    gcloud projects list --format="json" >$FILE
    gcloud config set project (cat $FILE | jq -r '.[].projectId' | fzf --print-query --preview "cat $FILE | jq -r '.[] | select( .projectId | contains(\"{1}\"))'" | tr -d '\n')
end

function k-clean
   for i in (kubectl get pods -A | grep -Ei 'OOMKilled|ContainerStatusUnknown|Shutdown|Error|Terminated|Completed|Evicted' | cut -d ' ' -f1 | sort -u)
      for p in (kubectl get pods -n $i | grep -Ei 'OOMKilled|ContainerStatusUnknown|Shutdown|Error|Terminated|Completed|Evicted' | cut -d ' ' -f1 )
        kubectl delete pod -n $i $p
      end
   end
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

direnv hook fish | source

#######################################################################
#                                tmux                                 #
#######################################################################

if status is-interactive
and not set -q TMUX
    if tmux has-session -t home
	exec tmux attach-session -t home
    else
        tmux new-session -s home
    end
end
