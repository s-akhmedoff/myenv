# Exports
export BROWSER="firefox"
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$HOME/bin:/usr/local/bin:$HOME/go/bin:$PATH
export ZSH=$HOME/.oh-my-zsh
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"

# Aliases
alias off="poweroff"
alias mkdir="mkdir -p"
alias projects="cd $GOPATH/src"

# ZSH Configurations
ZSH_THEME="ys"

export UPDATE_ZSH_DAYS=1

ENABLE_CORRECTION="true"

HIST_STAMPS="mm/dd/yyyy"

plugins=(
    common-aliases
    genpass
    git
    gitfast
    git-prompt
    sudo
    systemd
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    colorize
    web-search
)

source $ZSH/oh-my-zsh.sh

# ZSH Plugins Configuration
ZSH_WEB_SEARCH_ENGINES=(yandex "https://yandex.uz/search/?text=")

# Other
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vi'
else
    export EDITOR='vim'
fi
