#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

readonly ENVIRONMENT=$1
readonly PROJECT_SUFFIX=$2
readonly DISTRIBUTION=$3
readonly BRANCH=${4:-master}
readonly ENVIRONMENT_PATH="${DIR}/../../app-${ENVIRONMENT}"

source "${DIR}/load-env.sh"

echo "${info} Initialize environement '${bldwht}${ENVIRONMENT}${txtrst}' from ${bldwht}${DISTRIBUTION}${txtrst} with branch '${bldwht}${BRANCH}${txtrst}'"

# Git clone
if [ ! -d ${ENVIRONMENT_PATH} ]; then
  echo "${info} Cloning your distribution"
  git clone -b ${BRANCH} ${DISTRIBUTION} ${ENVIRONMENT_PATH} > /dev/null 2>&1
  if [ $? != 0 ]; then
    echo "${warn} Unable to clone your distribution"
    exit 1
  fi
else
  echo "${skip} Cloning distribution directory '${bldwht}app-${ENVIRONMENT}${txtrst}' exist"
fi

# Deploy env file
if [ ! -f ${ENVIRONMENT_PATH}/Build/Environment/.env ]; then
  echo "${info} Deploy default env file to Build/Environment/.env"
  mkdir -p ${ENVIRONMENT_PATH}/Build/Environment/
  cp ${DIR}/../.env ${ENVIRONMENT_PATH}/Build/Environment/
  echo "PROJECT_NAME=${ENVIRONMENT}" >> ${ENVIRONMENT_PATH}/Build/Environment/.env
  echo "PROJECT_SUFFIX=${PROJECT_SUFFIX}" >> ${ENVIRONMENT_PATH}/Build/Environment/.env
else
  echo "${skip} Deploy default env file, file exists"
fi

# Default docker compose
if [ ! -f ${ENVIRONMENT_PATH}/docker-compose.yml ]; then
  echo "${info} Deploy default docker-compose.yml file in the root directory of your distribution"
  cp ${DIR}/../docker-compose.yml ${ENVIRONMENT_PATH}/docker-compose.yml
else
  echo "${skip} Deploy default docker-compose.yml, file exists"
fi

# Default docker compose override
if [ ! -f ${ENVIRONMENT_PATH}/docker-compose.override.yml ]; then
  echo "${info} Deploy default docker-compose.override.yml file in the root directory of your distribution"
  cp ${DIR}/../docker-compose.override.yml ${ENVIRONMENT_PATH}/docker-compose.override.yml
else
  echo "${skip} Deploy default docker-compose.override.yml, file exists"
fi

# Default docker compose
if [ ! -f ${ENVIRONMENT_PATH}/Build/Docker/docker-compose.yml ]; then
  echo "${info} Deploy build docker-compose.yml file to Build/Docker/docker-compose.yml"
  mkdir -p ${ENVIRONMENT_PATH}/Build/Docker/
  cp ${DIR}/../Build/docker-compose.yml ${ENVIRONMENT_PATH}/Build/Docker/docker-compose.yml
else
  echo "${skip} Deploy build docker-compose.yml, file exists"
fi
