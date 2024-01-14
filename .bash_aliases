unalias -a

# infinite history
export HISTSIZE=
export HISTFILESIZE=
export HISTFILE="${HOME}/.bash_history"
export HISTTIMEFORMAT='[%F %T] '
export HISTCONTROL='ignoredups:erasedups'
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

function add_path() {
  if [[ :$PATH: != *:"$1":* ]]; then
    export PATH=$PATH:"$1"
  fi
}

add_path "$HOME/.local/bin"

shopt -s cdspell cmdhist
shopt -s histappend      # append history
shopt -s checkhash       # checks hash for command
shopt -s extglob         # Necessary for programmable completion.

# bash strict mode
# set -euo pipefail
# IFS=$'\n\t'

# return the failed command exit status
set -o pipefail

# set -o vi
export PS1='\n\[\e[32m\]\w\[\e[00m\] '

function update() {
  sudo apt update
  sudo apt upgrade -y

  sudo apt clean
  sudo apt autoremove -y
}

export EDITOR='nvim -p'
export VISUAL="$EDITOR"

# Make ls, du, df and possibly other programs report sizes in a human-readable
# way by default (e.g. `df` implicitly becomes `df -h`).
export BLOCKSIZE='human-readable'

# start default bash shell without loading user bashrc
alias sbrc='source ~/.bashrc'
alias bnrc='bash --noprofile --norc'

# use bat for cat
if [ -x "$(command -v bat)" ]; then
  alias cat='bat --paging=never'
fi

alias la='ll -A'
alias ll='ls -lv --group-directories-first'
alias ls='ls -h --color=auto --group-directories-first'

# Nice alternative to 'recursive ls' ...
alias tree='tree -Csuh'

# cd ..
alias ..='cd ..'
alias ...='builtin cd ..; builtin cd ..'
alias ....='builtin cd ..; builtin cd ..; builtin cd ..'

# Always copy contents of directories (r)ecursively and explain(v) what was done
alias cp='cp -rv'

# parenting changing permission on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Prompt when removing more than three Files and verbose
alias rm='rm -vI --preserve-root'

# Explain (v) what was done when moving a file and Prompt before override(i)
alias mv='mv -iv'

# Create any non-existent (p)arent directories and explain(v) what was done
alias mkdir='mkdir -pv'

# show type + path
alias which='type -a'

# free human
alias free='free -h'

# summarize disk usage in human readable form
alias disk='du -aBM 2>/dev/null | sort -nr | fzf'

# default to unified format for diffs
alias diff='diff -uZB --color=always'

# open multiple files in buffer
alias vim='nvim -p'

# clear screen do not clear the terminal scrollback buffer
alias c='clear -x'

alias e="edit"
alias q='exit 0'

function t() {
  if [[ "$TERM" =~ 'tmux' ]] && [ -n "$TMUX" ]; then
    return 0
  fi

  local TMUX_SESSION_NAME=${TERM_PROGRAM:- terminal}

  if tmux has-session -t ${TMUX_SESSION_NAME} &> /dev/null; then
    exec tmux attach-session -d -t ${TMUX_SESSION_NAME}
  else
    exec tmux new-session -t ${TMUX_SESSION_NAME}
  fi
}

alias tls='tmux list-session'

# tmux clear session
function tcs() {
  tmux list-session -F '#{session_name}' |
    grep -v $(tmux display-message -p '#{session_name}') |
    xargs -L 1 --no-run-if-empty tmux kill-session -t
}

# more info pstree
alias pstree='pstree --hide-threads --show-pids'

# Get IP Address
alias myip='hostname -I | cut --delimiter " " --fields=1,1'

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n" | sort | less'

# debug mode, print commands and function calls
alias debug='set -o nounset; set -o xtrace'

# allows to expand xargs argument into aliases
# trailing space causes the next word expanded
# run command for each argument separated by whitespaces
alias xargs='xargs --no-run-if-empty '

alias sqlite='sqlite3'

# 3.6.6 Here Documents
# alias wf='cat <<- "EOF" >'

# Show contents of the directory after changing to it
function cd() {
  builtin cd "$@" && ls

  if [[ $? -ne 0 ]] && [[ -f $@ ]]; then
    builtin cd "${@%/*}" && ls
  fi
}

# create parent directory if necessary and cd
function mkcd() {
  mkdir -pv "$1" && builtin cd "$1"
}

#--------------------------------------------------------------------------------

alias curl='curl --silent'

# get server headers
alias header='curl -I'

# list all open ports
alias ports='sudo netstat -tulanp'

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'

#--------------------------------------------------------------------------------

alias fzf-tmux='fzf-tmux -p -w 90% -h 60% --'

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Use fd (https://github.com/sharkdp/fd) instead of the default find
_fzf_compgen_path() {
  fd --type f --type l --follow --exclude '.git' . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --follow --exclude '.git' . "$1"
}

export FZF_COMPLETION_TRIGGER='**'

# FZF use fd instead of find
export FZF_ALT_C_COMMAND='fd --type directory --exclude .git'
export FZF_DEFAULT_COMMAND='fd --type f --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_OPTS='
  --height=90% --layout=reverse --info=hidden --border=none

  --preview "bat --plain --color=always {}"
  --preview-window=bottom,70%,border-rounded,wrap,hidden

  --bind "alt-k:up"
  --bind "alt-j:down"
  --bind "alt-l:accept"
  --bind "change:first"

  --bind "btab:toggle+up"
  --bind "tab:toggle+down"

  --bind "alt-a:toggle-all"
  --bind "alt-x:toggle-preview"

  --bind "alt-b:preview-page-up"
  --bind "alt-f:preview-page-down"

  --cycle --literal --tabstop=2 --exit-0

  --color=fg:#c0c0c0,bg:#000000,hl:#5f87af
  --color=fg+:#c0c0c0,bg+:#000000,hl+:#5fd7ff
  --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff
  --color=marker:#87ff00,spinner:#af5fff,header:#87afaf
'

function fzf-search-widget() {
  IFS=: read -ra selected < <(
    rg --color=always --line-number --no-heading --smart-case "${*:-}" |
      fzf --ansi --delimiter : \
      --preview 'bat --style=numbers --color=always --pager=never --highlight-line={2} -- {1}' \
  )

  if [ -n "${selected[0]}" ]; then
    if [[ ${VSCODE_TERMINAL} != '' ]]; then
      code --reuse-window --goto "${selected[0]}:${selected[1]}"
    else
      vim "${selected[0]}" "+${selected[1]}"
    fi
  fi
}

function fzf-man() {
	MAN="/usr/bin/man"
  $MAN -k . |
    fzf --reverse \
      --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | xargs $MAN" |
    awk '{print $1 "." $2}' | tr -d '()' | xargs -r $MAN
}

function fzf-ps-env() {
  PS_PID=$(ps -ef |
    fzf --bind='ctrl-r:reload(date; ps -ef)' \
        --preview='sudo xargs -0 -L1 -a /proc/{2}/environ' | awk '{print $2}')

  if [ -z "$PS_PID" ]; then
    return
  fi

  sudo xargs -0 -L1 -a /proc/${PS_PID}/environ | fzf --multi
}

function fzf-shell-eval() {
  # concatenate multiple command output
  # without running each into separate subshell
  {
    compgen -A alias    -P '[alias] '
    compgen -A arrayvar -P '[array] '
    compgen -A builtin  -P '[builtin] '
    compgen -A function -P '[function] ' | grep -v '^\[function\] _'
    compgen -A variable -P '[variable] ' | grep -v '^\[variable\] _'
  } | fzf
}

function fzf-shell-eval-widget() {
  local input="$(fzf-shell-eval)"
  local selected="$(echo $input | cut -d ' ' -f2)"

  if [[ "$input" == "[array] "* ]]; then
    selected="\${$selected[@]}"
  elif [[ "$input" == "[variable] "* ]]; then
    selected="\${$selected}"
  fi

  if [[ "${READLINE_LINE:0:READLINE_POINT}" != '' ]] && [[ "$input" == "[function] "* || "$input" == "[alias] "* ]]; then
    selected="\$(${selected})"
  fi

  READLINE_LINE="${READLINE_LINE:0:READLINE_POINT}${selected}${READLINE_LINE:READLINE_POINT}"
  READLINE_POINT=$((READLINE_POINT + ${#selected}))
}

alias fzf-file-picker='__fzf_select__'

bind -m emacs-standard -x '"\ef": fzf-file-widget'
bind -m emacs-standard -x '"\es": fzf-search-widget'
bind -m emacs-standard -x '"\e`": fzf-shell-eval-widget'

#--------------------------------------------------------------------------------

# Creates an archive (*.tar.gz) from given directory.
function maketar() {
  tar cvzf "${1%%/}.tar.gz" "${1%%/}/"
}

# Create a ZIP archive of a file or folder.
function makezip() {
  zip -r "${1%%/}.zip" "$1"
}

#--------------------------------------------------------------------------------

alias dpa='dps --all'
alias dim='docker images'
alias drm='docker-container-picker -a | xargs docker rm -f'
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.State}}\t{{.Image}}"'

function docker-container-picker() {
  docker ps --no-trunc --format 'table {{.Names}}\t=> {{.Image}}\t=> {{.Status}}' "$@" |
    sed '1d' | fzf --multi | awk -F '=>' '{print $1}' | tr -d ' '
}

function dsh() {
  docker-container-picker |
    xargs -L 1 -oI '{}' docker exec -it '{}' "$@" /bin/bash
}

# docker logs
function dls() {
  containers=$(docker-container-picker -a | xargs)
  container_count=$(echo ${containers[@]} | wc -w)

  if (( container_count == 0 )); then
    return
  fi

  if [[ "$TERM_PROGRAM" != 'tmux' ]]; then
    docker logs --follow ${containers[@]}
    return
  fi

  for container in ${containers[@]}; do
    state=$(docker ps -a --filter="name=$container" --format='{{.State}}')
    if [[ $state == 'exited' ]]; then
      tmux new-window -n $container "docker logs $container | less $@"
    else
      tmux new-window -n $container "docker logs --follow $container $@"
    fi
  done
}

function docker-prune() {
  docker ps -a -q     | xargs --no-run-if-empty docker rm -f
  docker images -a -q | xargs --no-run-if-empty docker rmi -f
  docker system prune --all --force --volumes
}

# generic docker container picker
# useful for misc commands like cp ..etc
function docker-ps-widget() {
  local selected="$(docker-container-picker -a | xargs)"
  READLINE_LINE="${READLINE_LINE:0:READLINE_POINT}$selected${READLINE_LINE:READLINE_POINT}"
  READLINE_POINT=$((READLINE_POINT + ${#selected}))
}

# replace with container name
bind -m emacs-standard -x '"\ed": docker-ps-widget'

#--------------------------------------------------------------------------------

# nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
alias dot="git --git-dir=$HOME/.bare/dotfiles/ --work-tree=$HOME"

alias gst='git status'
alias gpl='git pull origin $(gcb)'
alias gps='git push saurabh $(gcb)'
alias gcb='git branch --show-current'

# push only tracked files
function gspu() {
  git stash push -m "${@-$(date)}"
}

function gspo() {
  git stash list |
    fzf --multi --delimiter ':' --preview 'git stash show -p {1}' | cut -d ':' -f 1 |
    xargs git stash apply
}

function gco() {
  git --no-pager branch -vv |
    fzf --multi | awk '{print $1}' | sed 's/.* //' |
    xargs git checkout
}

function grs() {
  git status --untracked-files=no --short --renames | cut -c4- |
    fzf --multi --preview 'git diff --color=always {1}' |
    xargs -t -p git restore "$@"
}

function gad() {
  git ls-files -m -o --exclude-standard |
    fzf --multi --print0 --preview 'git diff --color=always {1}' |
    xargs -0 -r -t git add
}

function gsw() {
  git log --format='%h %s [%cr]' |
    fzf --multi --height='90%' \
        --preview 'git show --color=always {1}' \
        --bind 'ctrl-r:reload(git log --reverse --format="%h %s [%cr]")' |
    awk '{print $1}'
}

function gfh() {
  REMOTE_NAME="$@"

  if [ -z $REMOTE_NAME ]; then
    REMOTE_NAME=$(git remote | fzf)
  fi

  if [ -z $REMOTE_NAME ]; then
    return
  fi

  readarray -t BRANCHES <<< $(git-remote-branch-picker ${REMOTE_NAME})

  for BRANCH_NAME in ${BRANCHES[@]}; do
      git fetch --update-head-ok ${REMOTE_NAME} +${BRANCH_NAME}:${BRANCH_NAME}
  done

  if (( ${#BRANCHES[@]} == 1 )); then
    git checkout ${BRANCHES[0]}
  fi
}

function git-branch-picker() {
  git for-each-ref --sort=-committerdate refs/heads "$@" \
    --format='%(authordate:short) %(objectname:short) %(refname:short) %(committerdate:relative)' |
   fzf --multi | cut -d ' ' -f 3
}

function git-remote-branch-picker() {
  git ls-remote --quiet --refs ${@:- origin} |
    cut -f 2 | sed 's#^refs/\(heads\|tags\)/##' | grep -vE '^refs' |
    fzf --multi
}

function git-branch-picker-widget() {
  local selected="$(git-branch-picker | xargs)"
  READLINE_LINE="${READLINE_LINE:0:READLINE_POINT}$selected${READLINE_LINE:READLINE_POINT}"
  READLINE_POINT=$((READLINE_POINT + ${#selected}))
}

bind -m emacs-standard -x '"\eg": git-branch-picker-widget'

#--------------------------------------------------------------------------------

alias m='minikube'
alias k='minikube kubectl --'

# use local docker repository
# eval $(minikube docker-env)

#--------------------------------------------------------------------------------

function wsl-linux() {
  if grep -qEi '(Microsoft|WSL)' /proc/version &> /dev/null; then
    return 0
  fi

  return 1
}

if wsl-linux; then
  alias copy='clip.exe'
  # The sed will remove carriage-returns
  alias paste="powershell.exe Get-Clipboard | sed 's/\r//'"
fi

#--------------------------------------------------------------------------------

function db-scan() {
  dy scan --keys-only "$@" | sed '1d' | fzf --preview 'dy get {1} {2}'
}

alias db='dy --port 8000 --region local'
alias db-get='db-scan | xargs dy get | jq'

alias db-up='docker compose -f ~/.compose/dynamodb.yaml up -d'
alias db-down='docker compose -f ~/.compose/dynamodb.yaml down -v'

# --------------------------------------------------------------------------------

export GOOS=linux
export GOARCH=amd64
export GOPATH=$HOME/go
add_path "${HOME}/go/bin"
add_path '/usr/local/go/bin'

# disable dynamic linking
# disable symbol optimization
alias go-debug='CGO_ENABLED=0 go build -gcflags "all=-N -l"'

function go-test() {
  ARGS=()

  if [[ ! -z "$COVERAGE_FILE" ]]; then
    ARGS=("-coverprofile=${COVERAGE_FILE}")
  fi

  go test -timeout 6h -vet=all -v -count=1 ${ARGS[@]} "${@:-./...}"
}

# check for coverage
function go-cover() {
  COVERAGE_FILE='/tmp/go-code-cover'
  rm -f $COVERAGE_FILE ${COVERAGE_FILE}.html

  go-test "${@}"
  go tool cover -func $COVERAGE_FILE
  go tool cover -html=$COVERAGE_FILE -o ${COVERAGE_FILE}.html

  unset COVERAGE_FILE
}

# --------------------------------------------------------------------------------

add_path "$HOME/.cargo/bin"

# --------------------------------------------------------------------------------

alias pip='pip3'
alias python='python3'
alias webshare='python3 -m http.server 8081'

# refer the file name inside the folder as module
# skutils/fzf.py -> import fzf
export PYTHONPATH="${HOME}/.local/lib/skutils"

# --------------------------------------------------------------------------------

if [ -f ~/.bash_aliases.local ]; then
  source ~/.bash_aliases.local
fi
