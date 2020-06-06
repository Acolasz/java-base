#!/bin/sh

usage() {
cat << EOF
Usage: for Docker build needs a "${ENV_FILE_NAME}" file and it contents following for example:
--------------
U_VERSION=172
--------------
EOF
}

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
ENV_FILE_NAME=.env
ENV_FILE=./.env
if [[ -f "${ENV_FILE}" ]]; then
    echo "The ${ENV_FILE} file exits."
	docker-compose.exe -f docker-compose.yml build
else 
    echo "Missing ${ENV_FILE} file."
	usage
	exit 1
fi
  
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"