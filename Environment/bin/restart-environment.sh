#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

readonly ENVIRONMENT=$1

source "${DIR}/load-env.sh"

if ! environment_exists ${APP}; then
  echo "${warn} Application '${txtbld}${APP}${txtrst}' does not exists, you must run bin/init first"
  exit 1
fi

${DIR}/stop-environment.sh ${ENVIRONMENT}
${DIR}/start-environment.sh ${ENVIRONMENT}
