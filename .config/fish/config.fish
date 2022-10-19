#######################################################################
#                            main settings                            #
#######################################################################

fish_add_path /usr/local/sbin
fish_add_path $HOME/bin
fish_add_path $HOME/.cargo/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

# set default username to hide user@host ... see agnoster theme
set DEFAULT_USER steinbrueckri

# show full path
set -U fish_prompt_pwd_dir_length 0

# theme
set theme_color_scheme "Catppuccin Frappe"

# fzf theme
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

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
fundle plugin catppuccin/fish
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
set -g theme_display_git_default_branch yes
set -g theme_title_use_abbreviated_path no
set -g theme_display_git_dirty_verbose yes
set -g theme_display_k8s_context yes
set -g theme_display_k8s_namespace yes
set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_title_display_user yes
set -g theme_display_date no
set -g theme_newline_cursor yes
set -g theme_newline_prompt '$ '

function bobthefish_colors -S -d 'Define a custom bobthefish color scheme'

  # optionally include a base color scheme...
  __bobthefish_colors default

  # --> special
  set -l foreground dadae8
  set -l selection 3e4058

  # --> palette // Catppuccin Frappé
  set -l rosewater f2d5cf
  set -l flamingo eebebe
  set -l pink f4b8e4
  set -l mauve ca9ee6
  set -l red e78284
  set -l maroon	ea999c
  set -l peach ef9f76
  set -l yellow	e5c890
  set -l green a6d189
  set -l teal	81c8be
  set -l sky 99d1db
  set -l sapphire	85c1dc
  set -l blue	8caaee
  set -l lavender	babbf1
  set -l text	c6d0f5
  set -l subtext1	b5bfe2
  set -l subtext0	a5adce
  set -l overlay2	949cbb
  set -l overlay1	838ba7
  set -l overlay0	737994
  set -l surface2	626880
  set -l surface1 51576d
  set -l surface0	414559
  set -l base 303446
  set -l mantle 292c3c
  set -l crust 232634

  # then override everything you want! note that these must be defined with `set -x`
  set -x color_username                 $overlay1 $blue --bold
  set -x color_hostname                 $overlay1 $sky
  set -x color_repo_dirty               $maroon $surface2
  set -x color_repo                     $green $surface2
  set -x color_repo_work_tree           $mauve $surface2 --bold
  set -x color_repo_staged              $yellow $surface2
  set -x color_k8s                      $sapphire $surface2 --bold
end

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

# kubernetes stuff
alias kx="kubectx"
alias k="kubectl"
alias kc="kubecolor"
alias kn='kubens'
alias k-debug="kubectl run --namespace default -i --tty 'debug-default-$USER' --image=steinbrueckri/debug --restart=Never --rm=true -- bash"
alias k-debug-app="kubectl run --namespace istio-apps -i --tty 'debug-$USER' --image=steinbrueckri/debug --restart=Never --rm=true -- bash"

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
alias dig="dog "
alias hosts="hosts --auto-sudo"
alias tx='tmuxinator'
alias ls='exa --icons'
alias top='btop'

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

#######################################################################
#                              functions                              #
#######################################################################

function gcp-project
    set FILE "$HOME/.gcp-project-list.json"
    # TODO: only if the file is older then 1d or if --force is set
    gcloud projects list --format="json" >$FILE
    gcloud config set project (cat $FILE | jq -r '.[].projectId' | fzf --print-query --preview "cat $FILE | jq -r '.[] | select( .projectId | contains(\"{1}\"))'" | tr -d '\n')
end

function k-clean
   for i in (kubectl get pods -A | grep -Ei 'OOMKilled|ContainerStatusUnknown|Shutdown|Error|Terminated|Completed' | cut -d ' ' -f1 | sort -u)
      for p in (kubectl get pods -n $i | grep -Ei 'OOMKilled|ContainerStatusUnknown|Shutdown|Error|Terminated|Completed' | cut -d ' ' -f1 )
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

direnv hook fish | source
