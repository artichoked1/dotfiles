if status is-interactive

### ALIASES ###

alias g=git
alias gs='git status'
alias gc='git commit'
alias gcm='git commit -m'
alias gps='git push'
alias gpl='git pull'
alias ga='git add'
alias pn=pnpm
alias python=python3
alias k=kubectl
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

end


### APP-SPECIFIC ENV VARS ###

set -gx PICO_SDK_PATH $HOME/pico/pico-sdk
set -gx PICO_EXAMPLES_PATH $HOME/pico/pico-examples
set -gx PICO_EXTRAS_PATH $HOME/pico/pico-extras
set -gx PICO_PLAYGROUND_PATH $HOME/pico/pico-playground

set -gx KUBECONFIG $HOME/.kube/pleiades.yaml

set -gx NVM_SYMLINK_CURRENT true

set -gx PATH $HOME/.local/bin $PATH


### APP-SPECIFIC BEHAVIOUR ###

if test -f .nvmrc
    nvm install
end

### FISH-SPECIFIC BEHAVIOUR ###

set fish_greeting

starship init fish | source
