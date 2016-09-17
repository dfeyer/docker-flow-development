#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

readonly ENVIRONMENT=$1

source "${DIR}/load-env.sh"

"${DIR}/docker-compose.sh" ${ENVIRONMENT} stop
