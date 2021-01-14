###########################################
########         zsh conf         #########
###########################################

export PATH=$HOME/bin:$HOME/go/bin/:/usr/local/bin:/opt/puppetlabs/pdk/bin/:/opt/puppetlabs/bin/:/Users/steinbrueckri/Library/Python/3.7/bin/:$PATH
export ZSH=/Users/steinbrueckri/.oh-my-zsh
export EDITOR="/usr/bin/vim"
ZSH_THEME="agnoster"
DEFAULT_USER=steinbrueckri
RPROMPT='%{$fg[$color]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'

# Plugins (https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins)
plugins=(
	terraform
	git
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
  	httpie
  	yarn
	docker
	sublime
	)

# Source
source $ZSH/oh-my-zsh.sh
source /usr/local/etc/zsh-kubectl-prompt/kubectl.zsh # ZSH plugins installiert via brew

# TMUX
ZSH_TMUX_AUTOSTART=true

## Alias ######################################################################

## Configs
alias vimconfig="vim ~/.vimrc"
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

## GCP
alias gcpil='gcloud compute instances list'
alias gcpal='gcloud compute addresses list'
alias gcpssh='gcloud compute ssh'
alias gcpsshi='gcloud compute ssh --internal-ip'
alias gcpsshiap='gcloud compute ssh --tunnel-through-iap'
alias gcpca='gcloud config configurations activate'

alias gcp04webimt01d='CLOUDSDK_CORE_PROJECT=mms-cif-imtron-web-t-1000 gcpsshiap gcp04webimt01d'
alias gcp04webimt01p='CLOUDSDK_CORE_PROJECT=mms-cif-imtron-web-p-1000 gcpsshiap gcp04webimt01p'

## Docker
alias dr="docker run -it --rm --entrypoint /bin/sh"
alias drr="docker run -u root -it --rm --entrypoint /bin/sh"
alias rm-container="docker rm -fv $(docker ps -a -q)"
alias rm-images="docker rmi $(docker images -q)"

## Todos
function todo () {
  if [[ $# -eq 0 ]]; then
    open -a "Things3"
  else
    open "things:///add?when=today&deadline=today&title=$@"
  fi
}

## hosts
alias hosts="hosts --auto-sudo"

## K8s
export PATH="${PATH}:${HOME}/.krew/bin"
alias kx='kubectx'
alias kn='kubens'
alias k-debug="kubectl run --namespace default -i --tty 'debug-default-${USER}' --image=steinbrueckri/debug --restart=Never --rm=true -- bash"
alias k-debug-app="kubectl run --namespace istio-apps -i --tty 'debug-${USER}' --image=steinbrueckri/debug --restart=Never --rm=true -- bash"

## Tmux
alias tx='tmuxinator'

## Code
alias idea='open -na "IntelliJ IDEA.app" --args "$(pwd)"'

## MacOSX Lookscreen
alias lock="pmset displaysleepnow"

## Proxy
alias proxy="export http_proxy=${_HTTP_PROXY}; export HTTP_PROXY=${_HTTP_PROXY}; export https_proxy=${_HTTPS_PROXY}; export HTTPS_PROXY=${_HTTPS_PROXY}; export ftp_proxy=${_FTP_PROXY}; export FTP_PROXY=${_FTP_PROXY}; export rsync_proxy=${_RSYNC_PROXY}; export RSYNC_PROXY=${_RSYNC_PROXY}; export no_proxy=${_NO_PROXY}; export NO_PROXY=${_NO_PROXY}"
alias noproxy="unset http_proxy; unset HTTP_PROXY; unset https_proxy; unset HTTPS_PROXY; unset ftp_proxy; unset FTP_PROXY; unset rsync_proxy; unset RSYNC_PROXY; unset no_proxy; unset NO_PROXY"
alias curproxy="echo \"HTTP_PROXY=${http_proxy} \nHTTPS_PROXY=${https_proxy} \nFTP_PROXY=${ftp_proxy} \nRSYNC_PROXY=${rsync_proxy} \nNO_PROXY=${no_proxy}\""

## Misc
alias lol="git log --pretty=oneline --abbrev-commit --graph --decorate"
alias cwc="grep -Ev '^(;|#|//|$)'"
alias top='htop'
alias cat="bat --paging never "
alias ls="exa"

## Functions ##################################################################

## Corp proxy
_HTTP_PROXY=$(cat ${HOME}/.proxy/http_proxy)
_HTTPS_PROXY=$(cat ${HOME}/.proxy/https_proxy)
_FTP_PROXY=$(cat ${HOME}/.proxy/ftp_proxy)
_RSYNC_PROXY=$(cat ${HOME}/.proxy/rsync_proxy)
_NO_PROXY=$(cat ${HOME}/.proxy/no_proxy)

function proxy_set {
  echo "Enter Proxy like http://proxy.corp.int:80"
  read $PROXY

  mkdir -p ~/.proxy/
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
    npm config set proxy ${_HTTP_PROXY} &!
    npm config set https-proxy ${_HTTPS_PROXY} &!
    yarn config set proxy ${_HTTP_PROXY} &!
    yarn config set https-proxy ${_HTTPS_PROXY} &!
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

## init
function init {
  ## Show my if im dirty 
  cd ~/.config/yadm/repo.git && git diff --quiet || echo '💩💩💩 dotfiles are dirty 💩💩💩' && cd - > /dev/null  
  
#  ## Network location stuff
#  location="$(networksetup -getcurrentlocation)"
#  if [ $location = "Automatic" ]; then
#    echo -e "\e[32mWelcome in the R8alW0rld!\e[39m"
#    proxy_off
#  fi
#  if [ $location = "Media-Saturn" ]; then
#    echo -e "\e[32mWelcome in the media-saturn environment!\e[39m"
#    proxy_on
#  fi
}

## autocomplete ################################################################
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault
source <(kubectl completion zsh)
source <(gh completion -s zsh)
source <(fluxctl completion zsh)
source <(flux completion zsh)
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
source '/usr/local/share/zsh/site-functions/_hosts'

## exports ####################################################################
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export JAVA_HOME="$(/usr/libexec/java_home)"
export SSH_KEY_PATH="~/.ssh/rsa_id"

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

### ruby stuff
eval "$(rbenv init -)"
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$GEM_HOME/bin:$PATH"

### rust stuff
source $HOME/.cargo/env

# Source: https://github.com/ansible/ansible/issues/32499
# This is apparently due to some new security changes made in High Sierra that are breaking lots of Python things that use fork(). Rumor has it that adding
# export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES before your Ansible run should clear it up. The code that's causing issues is well below Ansible in the stack.

## init #######################################################################
init

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export GPG_TTY=$(tty)
