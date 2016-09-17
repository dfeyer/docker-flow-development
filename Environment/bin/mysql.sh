#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${DIR}/load-env.sh"

if ! environment_exists ${APP}; then
  echo "${warn} Application '${txtbld}${APP}${txtrst}' does not exists, you must run bin/init first"
  exit 1
fi

"${DIR}/docker-compose.sh" exec db mysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE $@
