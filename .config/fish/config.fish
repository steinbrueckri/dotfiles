#######################################################################
#                            main settings                            #
#######################################################################

# set default username to hide user@host ... see agnoster theme
set DEFAULT_USER steinbrueckri

# show full path
set -U fish_prompt_pwd_dir_length 0

# theme
set theme_color_scheme bobthefish

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
fundle init

#######################################################################
#                               prompt                                #
#######################################################################

set -g theme_color_scheme terminal2-light-black
set -g theme_powerline_fonts yes
set -g theme_display_git_default_branch yes
set -g theme_title_use_abbreviated_path no
set -g theme_display_git_dirty_verbose yes
set -g theme_display_k8s_context yes
set -g theme_display_k8s_namespace yes
set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_title_display_user yes
set -g theme_newline_cursor yes
set -g theme_newline_prompt '$ '

function bobthefish_colors -S -d 'Define a custom bobthefish color scheme'

    # Optionally include a base color scheme
    __bobthefish_colors default

    set -x color_k8s black white --bold

end

#######################################################################
#                               aliases                               #
#######################################################################

# mac stuff
alias sleepoff="sudo systemsetup -setcomputersleep Never"
alias sleepon="sudo systemsetup -setcomputersleep 10"
alias lock="pmset displaysleepnow"

# vim 4 the win!
alias vim="nvim"
alias vi="nvim"
alias v="nvim"

# kubernetes stuff
alias kx="kubectx"
alias k="kubectl"
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
alias gcp04webimt01d='CLOUDSDK_CORE_PROJECT=mms-cif-imtron-web-t-1000 gcpsshiap gcp04webimt01d'
alias gcp04webimt01p='CLOUDSDK_CORE_PROJECT=mms-cif-imtron-web-p-1000 gcpsshiap gcp04webimt01p'
alias gcp04laliga01d='CLOUDSDK_CORE_PROJECT=mms-lal-laliga-d-1337 gcpsshiap gcp04laliga01d'
alias gcp04laliga01p='CLOUDSDK_CORE_PROJECT=mms-lal-laliga-p-1337 gcpsshiap gcp04laliga01p'
alias gcp04manans01p='gcloud compute ssh gcp04manans01p --tunnel-through-iap --zone=europe-west4-b --project=mms-cif-config-mgmt-p-1000'
alias gcp04manans02p='gcloud compute ssh gcp04manans02p --tunnel-through-iap --zone=europe-west4-b --project=mms-cif-config-mgmt-p-1000'

## docker
alias docker="podman"
alias dr="docker run -it --rm --entrypoint /bin/sh"
alias rm-images="docker rmi (docker images -q)"

## Misc
alias pwgen="date +%s | sha256sum | base64 | head -c 32 ; echo"
alias lol="git log --pretty=oneline --abbrev-commit --graph --decorate"
alias cat="bat "
alias dig="dog "
alias hosts="hosts --auto-sudo"
alias tx='tmuxinator'

#######################################################################
#                               exports                               #
#######################################################################

# kubernetes stuff
export KUBE_EDITOR="nvim"
export PATH="$PATH:$HOME/.krew/bin"

# ansible stuff
export ANSIBLE_VAULT_PASSWORD_FILE="~/.vault-password-file"
export MOLECULE_DRIVER="podman"

# Source: https://github.com/ansible/ansible/issues/32499
# This is apparently due to some new security changes made in High Sierra that are breaking lots of Python things that use fork(). Rumor has it that adding
# export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES before your Ansible run should clear it up. The code that's causing issues is well below Ansible in the stack.
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

#######################################################################
#                              functions                              #
#######################################################################

function gcp-project
    set FILE "$HOME/.gcp-project-list"
    gcloud projects list --format="value(PROJECT_ID)" >$FILE
    gcloud config set project (cat $FILE | fzf)
end

#######################################################################
#                               source                                #
#######################################################################

source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
