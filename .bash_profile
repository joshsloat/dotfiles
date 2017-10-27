####################################################
# docker
####################################################
alias dcu="docker-compose up"
alias dcb="docker-compose build"
alias dcrm="docker-compose rm"
alias dckill="docker-compose kill"
alias dcforce="docker-compose up --build --force-recreate"
alias dcnocache="docker-compose build --no-cache --pull"
alias runtime="cd ~/git/rise-runtime"
alias frontend="cd ~/git/rise-frontend"
alias packages="cd ~/git/rise-packages"
alias privresources="cd ~/git/private-resources"
alias skipper="cd ~/git/skipper"

####################################################
# Custom Prompt (Git branch info)
# requires installation of git-completion.bash
# via curl command in dotfiles/install/git.sh
####################################################

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

DIR_COLOR="\[\e[0;32m\]"
GIT_BRANCH_COLOR="\[\e[0;36m\]"
GIT_CLEAN_COLOR="\[\e[1;32m\]"
GIT_DIRTY_COLOR="\[\e[0;31m\]"
PROMPT_COLOR="\[\033[38;5;172m\]"
RESET_COLOR="\[\e[0m\]"
PROMPT_CHARACTER="λ"

function __git_branch_status {
    if $(__git_repo_initialized); then
        if [[ -z $(git status -s) ]]; then
            echo -e "$GIT_CLEAN_COLOR ✔"
        else
            echo -e "$GIT_DIRTY_COLOR ✗"
        fi
    fi
}

function __git_repo_initialized {
    git ls-files >& /dev/null
}

function __git_branch_name {
    if $(__git_repo_initialized); then
        git symbolic-ref --short -q HEAD
    fi
}

function __prompt_command {
    PS1="\n$DIR_COLOR\w $GIT_BRANCH_COLOR$(__git_branch_name)$(__git_branch_status)$RESET_COLOR\n$PROMPT_COLOR$PROMPT_CHARACTER $RESET_COLOR"
}

PROMPT_COMMAND=__prompt_command