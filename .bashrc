#####################
## WELCOME FORTUNE ##
#####################
fortune -s | cowsay -f small
# fortune -s | cowsay -f cupcake

#############
## ALIASES ##
############

# Listing aliases
alias lsa="ls -a"
alias ..="cdl .."
alias ...="cdl ../.."
alias ...="cdl ../../.."

# Git aliases
alias gs="git status"
alias gd="git diff $1"
alias ga="git add $1"

# Quick path aliases
alias gotouni="cdl $HOME/documents/university"

# Quick python venv activation
alias eft="source $HOME/python_envs/eftcamb/bin/activate"

######################
## General settings ##
######################

###############
## FUNCTIONS ##
###############
# Switch themes
# ------------
use-theme() {
    # Directory where themes live
    local THEMES_DIR="$HOME/themes"
    local THEME=$1

    # Match arugment
    case "$1" in
      "" | "-h" | "--help")
        echo "Usage: use-theme <theme-name>"
        echo
        echo "Options:"
        echo "  -a, --avail, --available   List available themes"
        echo "  -h, --help                 Show this help message"
        echo
        echo "Example:"
        echo "  use-theme sasha"
        return 0
        ;;
      "-a" | "--avail" | "--available")
        echo "Available themes:"
        for theme in "$THEMES_DIR"/*; do
          [[ -d "$theme" ]] && echo "  $(basename "$theme")"
        done
        return 0
        ;;
      *)
        THEME="$1"
        ;;
    esac
    
    local SELECTED_THEME_DIR="$THEMES_DIR/$THEME"
    local COLORS_FILE="$SELECTED_THEME_DIR/colors.css"
    
    # Check if theme exists
    if [[ ! -d "$SELECTED_THEME_DIR" ]]; then
        echo "Theme '$THEME' not found in $THEMES_DIR"
	echo "Run 'use-theme --avail' to list available themes"
        return 1
    fi
    
    # Loop over app directories in the theme
    for app_dir in "$SELECTED_THEME_DIR"/*; do
        [[ ! -d "$app_dir" ]] && continue

        local app_name=$(basename "$app_dir")
        # local target_dir="$HOME/.config/$app_name"
        
        # Create directory if it does not exist	  
	mkdir -p "$HOME/.config/$app_name"
	
	# Iterate over files
	for config_file in "$app_dir"/*; do
          local source_file=$(basename "$config_file")
          local target_file="$HOME/.config/$app_name/$source_file"
          
	  if [[ "$source_file" == "style.css" ]]; then
	    # Merge colors.css with style.css
	    cat "$COLORS_FILE" "$config_file" > "$target_file"
          else
            # Symlink (overwrite existing)
            ln -sfn "$config_file" "$target_file"
	  fi
	done
    done
    
    # Reload apps as needed
    pkill waybar
    pkill hyprpaper
    pkill dunst

    nohup waybar >/dev/null 2>&1 & disown
    nohup hyprpaper >/dev/null 2>&1 & disown
    nohup dunst >/dev/null 2>&1 & disown
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
# Also use custom layout
# PS1='\[\e]0;\w\a\]\[\e[32m\](\w) $(parse_git_branch)\n\[\e[32m\]❯❯ \[\e[0m\]'

PS1='\[\e[32m\](\w) $(parse_git_branch)\n\[\e[32m\]❯❯ \[\e[0m\]'

# Set terminal title to current dir
update_terminal_title() {
    echo -ne "\033]0;~${PWD#$HOME}\007"
}

PROMPT_COMMAND=update_terminal_title



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

# Activate a target nix-shell env
# -------------------------------
activate() {
  local dir="$1"
  if [ -z "$dir" ]; then
    echo "Usage: activate <name-of-env>"
    echo "   or: activate <directory-containing-flake.nix>"
    return 1
  fi
  
  # Search in $HOME/environments by default
  case "$dir" in 
    /*|~*) ;;  # Absolute path was given, leave as is
    *) dir="$HOME/documents/devshells/$dir" ;;
  esac

  # Check if environment exists
  if [ ! -d "$dir" ]; then
    echo "Environment not found: $dir"
    return 1
  fi

  dir="$(realpath "$dir")"

  nix develop "$dir" \
     --extra-experimental-features nix-command \
     --extra-experimental-features flakes
}
