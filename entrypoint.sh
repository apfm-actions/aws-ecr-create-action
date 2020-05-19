#!/bin/sh
set -e

GITHUB_OWNER="${GITHUB_OWNER:=${GITHUB_REPOSITORY%%/*}}"
echo "::set-env name=GITHUB_OWNER::${GITHUB_OWNER}"

GITHUB_PROJECT="${GITHUB_PROJECT:=${GITHUB_REPOSITORY##*/}}"
echo "::set-env name=GITHUB_PROJECT::${GITHUB_PROJECT}"

ecr_perms()
{
	_ecr_perms_sid='1'
        _ecr_perms='{ "Version" : "2008-10-17", "Statement" : [ '
	while test "$#" -gt '1'; do
                _ecr_perms="${_ecr_perms} $(printf '{ "Sid" : "allowed-account-", "Effect" : "Allow", "Principal" : { "AWS" : "arn:aws:iam::%s:root" }, "Action" : [ "ecr:BatchCheckLayerAvailability", "ecr:BatchGetImage", "ecr:GetDownloadUrlForLayer" ] },' "${_ecr_perms_sid}" "${1}")"
		_ecr_perms_sid="$((${_ecr_perms_sid} + 1))"
        done
        ECR_PERMS="${ECR_PERMS%,} ]}"
        printf "${ECR_PERMS}"
}

DEBUG=
if test "${INPUT_DEBUG}" = 'true'; then
	DEBUG='--debug'
       	set -x
fi

if aws ecr create-repository --repository-name "${GITHUB_PROJECT}"; then
	aws ecr set-repository-policy --repository-name "${GITHUB_PROJECT}" --policy-text "$(ecr_perms ${INPUT_ALLOWED_ACCOUNTS})"
fi

if ECR_JSON="$(aws ecr describe-repositories --output=json --repository-name "${GITHUB_PROJECT}")"; then
	echo "::set-output name=uri::$(echo "${ECR_JSON}" | jq -r '.repositories[0].repositoryUri')"
	echo "::set-output name=arn::$(echo "${ECR_JSON}" | jq -r '.repositories[0].repositoryArn')"
fi
