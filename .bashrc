# Bash config

### GENERAL ENV VARS ###

export TERM="xterm-256color"
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=1000
export HISTFILESIZE=2000


### APP-SPECIFIC ENV VARS ###

# Herd
export PHP_INI_SCAN_DIR="/home/npatrick/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# Pico SDK
export PICO_SDK_PATH="$HOME/pico/pico-sdk"
export PICO_EXAMPLES_PATH="$HOME/pico/pico-examples"
export PICO_EXTRAS_PATH="$HOME/pico/pico-extras"
export PICO_PLAYGROUND_PATH="$HOME/pico/pico-playground"

# PNPM
export PNPM_HOME="$HOME/.local/share/pnpm"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# NVM
export NVM_DIR="$HOME/.nvm"


### PATH VARIABLE ###

export PATH="$PATH:/home/npatrick/.local/bin"
export PATH="$PATH:/home/npatrick/.config/herd-lite/bin"
export PATH="$PATH:$HOME/.local/share/yabridge"


### SHELL BEHAVIOR ###

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


### APP-SPECIFIC BEHAVIOR ###

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # Loads NVM
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # Loads completion

# Kubectl
complete -o default -F __start_kubectl k # Loads completion

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" # Loads homebrew env vars

# PNPM
if ! echo "$PATH" | grep -q "$PNPM_HOME"; then # Only add PNPM_HOME to PATH if it's not already there
    export PATH="$PNPM_HOME:$PATH"
fi

## PROMPT ###

# Initialize Starship prompt only if it's installed
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
else
    # Fallback to a simple prompt if starship is not installed
    export PS1="\[\e[2;32m\][\[\e[m\]\[\e[2;32m\]\u\[\e[m\]\[\e[2;32m\]]\[\e[m\] \[\e[1;93m\][\[\e[m\]\[\e[1;93m\]\w\[\e[m\]\[\e[1;93m\]]\[\e[m\] \[\e[36m\]>\[\e[m\] "
fi

### ALIASES ###

# Helpful ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Short app aliases
alias k='kubectl'
alias python='python3'
alias pn='pnpm'

# If on wayland, run force wayland mode on vscode:
code() {
    if [ "$WAYLAND_DISPLAY" ]; then
        /usr/bin/code --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland "$@"
    else
        /usr/bin/code "$@"
    fi
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


