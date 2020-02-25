###########################################
########         zsh conf         #########
###########################################

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/go/bin/:/usr/local/bin:/opt/puppetlabs/pdk/bin/:/opt/puppetlabs/bin/:/Users/steinbrueckri/Library/Python/3.7/bin/:$PATH
# Path to your oh-my-zsh installation.
export ZSH=/Users/steinbrueckri/.oh-my-zsh

# Theme (https://github.com/robbyrussell/oh-my-zsh/wiki/Themes)
ZSH_THEME="agnoster"
DEFAULT_USER=steinbrueckri

RPROMPT='%{$fg[$color]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'

# Plugins (https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins)
plugins=(
	terraform
	git
	git-extra-commands
	gitignore
	osx
	npm
	nmap
	mvn
	mosh
	man
	gradle
	iterm2
	kubectl
	web-search
	docker
	sublime
  zsh-kubectl-prompt
	)

# Source
source $ZSH/oh-my-zsh.sh

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# homebrew
#export HOMEBREW_GITHUB_API_TOKEN="dac215dc1f4d7a6bd3fc1f9f0db509721a8b2243"

# Custom
################################################################################
# Google SDK
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'


# Custom - Alias ################################################################################
## Configs
alias vimconfig="vim ~/.vimrc"
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

## Misc
alias lol="git log --pretty=oneline --abbrev-commit --graph --decorate"
alias cwc="grep -Ev '^(;|#|//|$)'"
alias git='hub'
alias top='htop'
alias cat="bat --paging never "

## GCP
alias gcpil='gcloud compute instances list'
alias gcpal='gcloud compute addresses list'
alias gcpssh='gcloud compute ssh'
alias gcpsshi='gcloud compute ssh --internal-ip'
alias gcpca='gcloud config configurations activate'

alias all='alias | grep'

## MacOSX Lookscreen
alias lock="pmset displaysleepnow"

## Git Update All (Update all git repositories under a base directory)
alias git-update-all="find . -name .git -type d | xargs -n1 -P4 -I% git --git-dir=% --work-tree=%/.. fetch --all --recurse-submodules"
alias gci="hub ci-status -v"

# Source: https://github.com/ansible/ansible/issues/32499
# This is apparently due to some new security changes made in High Sierra that are breaking lots of Python things that use fork(). Rumor has it that adding
# export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES before your Ansible run should clear it up. The code that's causing issues is well below Ansible in the stack.
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

_HTTP_PROXY=$(cat ${HOME}/.proxy/http_proxy)
_HTTPS_PROXY=$(cat ${HOME}/.proxy/https_proxy)
_FTP_PROXY=$(cat ${HOME}/.proxy/ftp_proxy)
_RSYNC_PROXY=$(cat ${HOME}/.proxy/rsync_proxy)
_NO_PROXY=$(cat ${HOME}/.proxy/no_proxy)

alias proxy="export http_proxy=${_HTTP_PROXY}; export HTTP_PROXY=${_HTTP_PROXY}; export https_proxy=${_HTTPS_PROXY}; export HTTPS_PROXY=${_HTTPS_PROXY}; export ftp_proxy=${_FTP_PROXY}; export FTP_PROXY=${_FTP_PROXY}; export rsync_proxy=${_RSYNC_PROXY}; export RSYNC_PROXY=${_RSYNC_PROXY}; export no_proxy=${_NO_PROXY}; export NO_PROXY=${_NO_PROXY}"
alias noproxy="unset http_proxy; unset HTTP_PROXY; unset https_proxy; unset HTTPS_PROXY; unset ftp_proxy; unset FTP_PROXY; unset rsync_proxy; unset RSYNC_PROXY; unset no_proxy; unset NO_PROXY"
alias curproxy="echo \"HTTP_PROXY=${http_proxy} \nHTTPS_PROXY=${https_proxy} \nFTP_PROXY=${ftp_proxy} \nRSYNC_PROXY=${rsync_proxy} \nNO_PROXY=${no_proxy}\""

function proxy_set {
  echo "Enter Proxy like http://asdasasdasd:8080"
  read $PROXY

  echo $PROXY > ~/.proxy/http_proxy
  echo $PROXY > ~/.proxy/https_proxy
  echo $PROXY > ~/.proxy/ftp_proxy
  echo $PROXY > ~/.proxy/rsync_proxy
}

function proxy_on {
    # System
    export http_proxy=${_HTTP_PROXY}
    export https_proxy=${_HTTPS_PROXY}
    export no_proxy=${_NO_PROXY}
    # NPM (Node.js)
    npm config set proxy http://${_HTTP_PROXY} &!
    npm config set https-proxy http://${_HTTPS_PROXY} &!
    yarn config set proxy http://${_HTTP_PROXY} &!
    yarn config set https-proxy http://${_HTTPS_PROXY} &!
}

function proxy_off {
    # System
    export http_proxy=
    export https_proxy=
    export no_proxy=
    # NPM (Node.js)
    npm config delete proxy &!
    npm config delete https-proxy &!
    yarn config delete proxy &!
    yarn config delete https-proxy &!
}

function check_env {
    location="$(networksetup -getcurrentlocation)"
    if [ $location = "Automatic" ]; then
      echo -e "\e[32mWelcome in the R8alW0rld!\e[39m"
      proxy_off
    fi
    if [ $location = "Media-Saturn" ]; then
      echo -e "\e[32mWelcome in the media-saturn environment!\e[39m"
      proxy_on
    fi
}

check_env

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault
eval "$(rbenv init -)"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home
source <(kubectl completion zsh)
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
