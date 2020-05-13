#!/bin/sh
set -e

GITHUB_OWNER="${GITHUB_OWNER:=${GITHUB_REPOSITORY%%/*}}"
echo "::set-env name=GITHUB_OWNER::${GITHUB_OWNER}"

GITHUB_PROJECT="${GITHUB_PROJECT:=${GITHUB_REPOSITORY##*/}}"
echo "::set-env name=GITHUB_PROJECT::${GITHUB_PROJECT}"

ecr_json()
{
	_ecr_json_sid='1'
        _ecr_json='{ "Version" : "2008-10-17", "Statement" : [ '
	while test "$#" -gt '1'; do
                _ecr_json="${_ecr_json} $(printf '{ "Sid" : "allowed-account-", "Effect" : "Allow", "Principal" : { "AWS" : "arn:aws:iam::%s:root" }, "Action" : [ "ecr:BatchCheckLayerAvailability", "ecr:BatchGetImage", "ecr:GetDownloadUrlForLayer" ] },' "${_ecr_json_sid}" "${1}")"
		_ecr_json_sid="$((${_ecr_json_sid} + 1))"
        done
        ECR_JSON="${ECR_JSON%,} ]}"
        printf "${ECR_JSON}"
}

DEBUG=
if test "${INPUT_DEBUG}" = 'true'; then
	DEBUG='--debug'
       	set -x
fi

if aws ecr create-repository --repository-name "${GITHUB_PROJECT}"; then
	aws ecr set-repository-policy --repository-name "${GITHUB_PROJECT}" --policy-text "$(ecr_json)"
fi
