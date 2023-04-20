# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/home/tomais/.oh-my-zsh"

plugins=(
#   dotnet
    git
    sudo
    common-aliases
#   npm
    python
    golang
#   adb
)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ ! -f ~/.zshrc.extra ]] || source ~/.zshrc.extra

# User configuration
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
[[ ! -d ~/bin ]] || export PATH="/home/tomais/bin:$PATH"
[[ ! -d ~/go/bin ]] || export PATH="$PATH:/home/tomais/go/bin"
[[ ! -d ~/.cargo/bin ]] || export PATH="$PATH:/home/tomais/.cargo/bin"
[[ ! -d ~/.local/share/gem/ruby/3.0.0/bin ]] || export PATH="$PATH:/home/tomais/.local/share/gem/ruby/3.0.0/bin"

hide_prompt() {
    typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status)
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
    typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=7
    typeset -g POWERLEVEL9K_STATUS_OK_BACKGROUND=4
    p10k reload
}

unhide_prompt() {
    source ~/.p10k.zsh
}

virsh_networks() {
   sudo virsh net-dhcp-leases default | awk '{print $6 ":\t" $5}' | tail -n +3 | head -n -1
}

alias l="ls -lah --hyperlink=auto"
alias ll="ls -lh --hyperlink=auto"
alias la="ls -a --hyperlink=auto"
alias lla="ls -lah --hyperlink=auto"

alias open=xdg-open

alias icat="kitty +kitten icat"
