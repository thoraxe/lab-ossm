#!/usr/bin/env bash

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MYHOME=${MYDIR}/..

TAG_PREFIX=${TAG_PREFIX:-example}

function fail() {
	echo $1
	exit 1
}

for project in customer preference recommendation ; do
	mvn -f ${MYHOME}/src/${project} clean package -DskipTests && \
		docker build -t ${TAG_PREFIX}/${project}:v1 ${MYHOME}/src/${project} || \
		fail "build of $project failed"
done

for version in v2 v3 ; do
	docker build -t ${TAG_PREFIX}/${project}:${version} ${MYHOME}/src/${project} || \
	fail "build of $project failed"
done
