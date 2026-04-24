#####################
## COLOUR SETTINGS ##
#####################
export LS_OPTIONS="--color=auto"
if command -v dircolors >/dev/null 2>&1; then
    eval "$(dircolors -b)"
fi
export LS_COLORS=$LS_COLORS:"di=1;3:*.zip=0;4;31"

force_color_prompt=yes

#############
## ALIASES ##
#############
alias ls="ls $LS_OPTIONS"

# Listing aliases
alias lsa="ls -a"
alias ..="cdl .."
alias ...="cdl ../.."
alias ....="cdl ../../.."
alias lt="tree -C -L 1 --dirsfirst"

# Git aliases
alias gs="git status"

###############
## FUNCTIONS ##
###############

# Grep function
# -------------
gf() {
  grep --color=always -R "$@"
}

# Git functions
# -------------
gd() {
  git diff "$@"
}

ga() {
  git add "$@"
}

# Extract a target compressed ball
# --------------------------------
extract() {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz) tar xzf "$1" ;;
      *.bz2) bunzip2 "$1" ;;
      *.rar) unrar x "$1" ;;
      *.gz) gunzip "$1" ;;
      *.tar) tar xf "$1" ;;
      *.tbz2) tar xjf "$1" ;;
      *.tgz) tar xzf "$1" ;;
      *.zip) unzip "$1" ;;
      *.7z) 7z x "$1" ;;
      *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


set-title() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}


# Parse changes in branch
# -----------------------
parse_git_branch() {
  # Get the current branch
  branch=$(git branch 2>/dev/null | grep '*' | sed 's/* //')

  # Check if there are unstaged changes
  git diff --quiet 2>/dev/null || unstaged="*"
  git diff --cached --quiet 2>/dev/null || staged="+"

  # Check if the branch is clean (no uncommitted changes)
  if [ -n "$unstaged" ]; then
    # Unstaged changes, show in bold red
    color="\e[38;5;1m"
  elif [ -n "$staged" ]; then
    # There are unstaged changes, show in italic orange
    color="\e[3;38;5;3m"
  else
    # No changes, show in green
    color="\e[38;5;2m"
  fi

  # Display branch only if inside a git repo
  [ -n "$branch" ] && echo -e "$color($branch$unstaged$staged)"
}

# Set PS1 to include git branch
PS1='\[\e[32m\](\w) $(parse_git_branch)\n\[\e[32m\]❯❯ \[\e[0m\]'

# Set terminal title to current dir
update_terminal_title() {
    echo -ne "\033]0;~${PWD#$HOME}\007"
}

if ! (readonly -p | grep -q 'PROMPT_COMMAND'); then
    PROMPT_COMMAND=update_terminal_title
fi


# Lists colour codes with their colour
# ------------------------------------
showcolours() {
  for i in {0..255}; do
    printf "\e[38;5;%dm%3d " $i $i
    if (( (i + 1) % 8 == 0 )); then echo; fi
  done
}

# List files in directory when changing into it
# ---------------------------------------------
cdl() { cd "$@" && ls; }
cdt() { cd "$@" && lt; }

###########
## PATH  ##
###########
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

################
## LOCAL CONF ##
################
# Machine-specific config (not tracked by dotfiles)
[ -f "$HOME/.bashrc_local" ] && source "$HOME/.bashrc_local"
