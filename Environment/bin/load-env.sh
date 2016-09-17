#!/usr/bin/env bash
ENVDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"

set -e
set -o allexport
source "$ENVDIR/.env"

# Text color variables
txtund=$(tput sgr 0 1)          # Underline
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldblu=${txtbld}$(tput setaf 4) #  blue
bldwht=${txtbld}$(tput setaf 7) #  white
txtrst=$(tput sgr0)             # Reset
info=${bldwht}[INFO]${txtrst}        # Feedback
pass=${bldblu}[PASS]${txtrst}
skip=${bldblu}[SKIP]${txtrst}
warn=${bldred}[WARN]${txtrst}
ques=${bldblu}?${txtrst}

environement_name() {
  echo "app-$1"
}

environment_exists() {
  local _APP=$1
  if [ -d $ENVDIR/../${_APP} ]; then
    return 0
  else
    return 1
  fi
}

load_environment() {
  local _APP=$1

  # Env
  if [ -f "$ENVDIR/../${_APP}/Build/Environment/.env" ]; then
    source "$ENVDIR/../${_APP}/Build/Environment/.env"
  fi

  if [ -f "$ENVDIR/../${_APP}//Build/Environment/.env.local" ]; then
    source "$ENVDIR/../${_APP}//Build/Environment/.env.local"
  fi
}

APP=$(environement_name $ENVIRONMENT)

load_environment $APP

set +o allexport
