export DEV_ROOT="$HOME/dev"

function venv(){
  if [[ ! -d .venv ]]; then
    python3 -m venv .venv
  fi
  source .venv/bin/activate
}

function ginit(){
  if [[ ! -d .git ]]; then 
    git init
  fi

  if [[ ! -f .gitignore ]]; then 
    LANG=$(echo -e "Python\nGo" | fzf --prompt "pick a language.")
    URL="https://raw.githubusercontent.com/github/gitignore/main/$LANG.gitignore"
    wget -qO .gitignore $URL
  fi
}

function dev(){

  if [[ -z $1 ]]; then
    directories=$(find $DEV_ROOT -maxdepth 1 -type d -exec basename {} \;)
    DEV_TASK=$(echo "$directories" | fzf --prompt "Select a task: " --height 20)
    if [[ -z $DEV_TASK ]] ; then
      return 0
    fi
  else
    DEV_TASK=$1
  fi
  export DEV_TASK

  DEV_DIR="$DEV_ROOT/$DEV_TASK"

  echo $DEV_DIR

  if [[ ! -d $DEV_DIR ]]; then
    read -p "$DEV_TASK doesn't exist. do you want to create it? (y/n): " answer
    case $answer in
    [Yy]* )
      mkdir $DEV_DIR -p
      ;;
    [Nn]* ) 
      return 0
      ;;
    * ) 
      return 0
      ;;
    esac
  fi

  cd $DEV_DIR
  if [[ -d .venv ]]; then
    venv
  fi

}
