#!/bin/bash

# shellcheck disable=2154

. lib/env.sh

log "add_item"

URL=$(jq -j .url <<< "${*}")
SITE=$(cut -d/ -f3 <<< "${URL}")

P='return text returned of (display dialog'
I='with icon caution'
T='with title "Add item"'

# Get name
CMD="${P} \"Enter name of new item\" ${I} ${T} default answer \"${SITE}\")"
NAME=$(2>&- osascript -e "${CMD}")

[ "${NAME}" == "" ] && exit

# Get username
SITE=$(cut -d/ -f3 <<< "${NAME}")
CMD="${P} \"Enter username for ${SITE}\" ${I} ${T} default answer \"${bwuser}\")"
USERNAME=$(2>&- osascript -e "${CMD}")

[ "${USERNAME}" == "" ] && exit

# Get password
GENERATED=$(curl -s "${API}/generate?length=20&uppercase&lowercase&number&special" | jq -j .data.data)
CMD="${P} \"Enter password for ${USERNAME}\" ${I} ${T} default answer \"${GENERATED}\" with hidden answer)"
PASSWORD=$(2>&- osascript -e "${CMD}")

[ "${PASSWORD}" == "" ] && exit

if [ "${PASSWORD}" != "${GENERATED}" ]; then
    CMD="${P} \"Confirm password for ${USERNAME}\" ${I} ${T} default answer \"\" with hidden answer)"
    CONFIRM=$(2>&- osascript -e "${CMD}")

    if [ "${CONFIRM}" != "${PASSWORD}" ]; then
	echo -n 'Add item,Passwords do not match'
	exit
    fi
fi

[ "${PASSWORD}" == "" ] && exit

# Build payload
JSON='{ "type": 1, "name": "'"${SITE}"'"'
JSON+=',"organizationId": '
if [ "${ORGANIZATION_ID}" == "" ]; then
    JSON+='null'
else
    JSON+='"'"${ORGANIZATION_ID}"'"'
fi
JSON+=',"login": {'
JSON+=' "username": "'"${USERNAME}"'"'
JSON+=',"password": "'"${PASSWORD}"'"'
JSON+=',"uris": [ { "match": null, "uri": "'"${URL}"'" } ]'
JSON+='} }'

PAYLOAD=$(echo "${JSON}" | base64)

# Add item
S=$(curl -s -H 'Content-Type: application/json' -d "${ENCODED_PAYLOAD}" "${API}"/object/item | jq -j .success)

echo -n "Added ${SITE//,/ },Success: ${S}"
