#!/bin/bash

read -r 2>/dev/null WF_VER <fix_flags_sentinel
[[ $alfred_workflow_version == "$WF_VER" ]] && exit
cd "$(dirname "$0")" || exit 1
/usr/bin/xattr -d com.apple.quarantine bitwarden-alfred-workflow 2>/dev/null
/bin/chmod +x bitwarden-alfred-workflow bw_auto_lock.sh bw_cache_update.sh 2>/dev/null
if [[ -n $alfred_workflow_version ]]; then
  echo "$alfred_workflow_version" >fix_flags_sentinel
fi
