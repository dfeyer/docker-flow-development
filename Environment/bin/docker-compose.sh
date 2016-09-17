#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOTDIR="$(cd $DIR && cd ../../ && pwd)"

readonly ENVIRONMENT=$1
shift
source "${DIR}/load-env.sh"

if ! environment_exists ${APP}; then
  echo "${warn} Application '${txtbld}${APP}${txtrst}' does not exists, you must run bin/init first"
  exit 1
fi

dockerComposeCommand="docker-compose"

echo "${info} Current project name: '${bldwht}${PROJECT_SUFFIX}${txtrst}'"
if ! [ -z $PROJECT_NAME ]; then
  echo "${info} Current application name: '${bldwht}${PROJECT_NAME}${txtrst}'"
  dockerComposeCommand+=" -p $PROJECT_NAME"
fi

composeFile="${APP}/docker-compose.yml"
customComposeFile="${APP}/$1"
if ! [ -z $customComposeFile ] && [ -f $customComposeFile ]; then
    composeFile="${customComposeFile}"
    shift
fi
overrideComposeFile="${composeFile/.yml/.override.yml}"
if [ ! -f $ROOTDIR/$composeFile ]; then
  echo "${warn} Missing docker-compose.yml in the application root directory"
  exit 1
fi
dockerComposeCommand+=" -f $ROOTDIR/$composeFile"

if [ -f $overrideComposeFile ]; then
    dockerComposeCommand+=" -f $overrideComposeFile"
fi

echo
echo "--------------- docker compose output ---------------"
${dockerComposeCommand} $@
