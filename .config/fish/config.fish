if status is-interactive

### ALIASES ###

abbr --add gco 'git checkout'
abbr --add gst 'git status'
abbr --add gb 'git branch'
abbr --add gl 'git pull'
abbr --add gp 'git push'

abbr --add .. 'cd ..'
abbr --add ... 'cd ../..'
abbr --add .... 'cd ../../..'

alias g=git
alias pn=pnpm
alias python=python3
alias k=kubectl
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias get_idf='. $HOME/esp/esp-idf/export.fish'

end


### APP-SPECIFIC ENV VARS ###

set -gx EDITOR nano
set -gx VISUAL nano

set -gx PICO_SDK_PATH $HOME/pico/pico-sdk
set -gx PICO_EXAMPLES_PATH $HOME/pico/pico-examples
set -gx PICO_EXTRAS_PATH $HOME/pico/pico-extras
set -gx PICO_PLAYGROUND_PATH $HOME/pico/pico-playground

set -U fish_user_paths ~/.bun/bin $fish_user_paths

# set -gx KUBECONFIG $HOME/.kube/pleiades.yaml

set -gx NVM_SYMLINK_CURRENT true

set -gx PATH $HOME/.local/bin $PATH

# fish_ssh_agent

### FISH-SPECIFIC BEHAVIOUR ###

set fish_greeting

starship init fish | source

#sudo last command

function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
    if test "$argv" = !!
        echo sudo $history[1]
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

### APP_SPECIFIC BEHAVIOUR ###

# auto activate python venvs
function __auto_venv --on-variable PWD
    if test -e venv/bin/activate.fish
        source venv/bin/activate.fish
    end
end

# NVM setup
function __auto_nvm --on-variable PWD
    if test -f .nvmrc
        set version (cat .nvmrc)
        nvm use $version >/dev/null 2>&1
    end
end

# Homebrew setup
if test -d /home/linuxbrew/.linuxbrew # Linux
	set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
	set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
	set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/Homebrew"
else if test -d /opt/homebrew # MacOS
	set -gx HOMEBREW_PREFIX "/opt/homebrew"
	set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
	set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/homebrew"
end
fish_add_path -gP "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin";
! set -q MANPATH; and set MANPATH ''; set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH;
! set -q INFOPATH; and set INFOPATH ''; set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH;
