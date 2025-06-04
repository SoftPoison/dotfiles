# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/Users/tomais/.oh-my-zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"
export EDITOR="vim"

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

if [[ -n "$KITTY_INSTALLATION_DIR" ]]; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ ! -f ~/.zshrc.extra ]] || source ~/.zshrc.extra


# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

eval "$(direnv hook zsh)"

# User configuration

# add stuff to path
[[ ! -d ~/bin ]] || export PATH="/Users/tomais/bin:$PATH"
[[ ! -d ~/go/bin ]] || export PATH="$PATH:/Users/tomais/go/bin"
[[ ! -d ~/.cargo/bin ]] || export PATH="$PATH:/Users/tomais/.cargo/bin"
[[ ! -d ~/.local/share/gem/ruby/3.0.0/bin ]] || export PATH="$PATH:/Users/tomais/.local/share/gem/ruby/3.0.0/bin"

# Add SSH keys from keychain to agent (if the agent doesn't have any keys yet)
(ssh-add -l || ssh-add --apple-load-keychain) &> /dev/null

# handy aliases

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

aws_mfa() {
    device="arn:aws:iam::XXXXXXXXXXXX:mfa/google_authenticator"
    echo -n "MFA code: "
    read mfa
    tf="$(mktemp)"
    aws sts get-session-token --serial-number "$device" --token-code "$mfa" > $tf
    export AWS_ACCESS_KEY_ID="$(jq -r '.Credentials.AccessKeyId' $tf)"
    export AWS_SECRET_ACCESS_KEY="$(jq -r '.Credentials.SecretAccessKey' $tf)"
    export AWS_SESSION_TOKEN="$(jq -r '.Credentials.SessionToken' $tf)"

    rm -f "$tf"   
}

#alias l="ls -lah --hyperlink=auto"
#alias ll="ls -lh --hyperlink=auto"
#alias la="ls -a --hyperlink=auto"
#alias lla="ls -lah --hyperlink=auto"

alias kitty="/Applications/kitty.app/Contents/MacOS/kitty"
alias icat="kitty +kitten icat"
