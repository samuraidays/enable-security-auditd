#!/bin/sh

## Log Function
readonly LOGFILE="/var/log/jamf-cis/${0##*/}.log"
readonly PROCNAME=${0##*/}
function log() {
  local fname=${BASH_SOURCE[1]##*/}
  /bin/echo "$(date '+%Y-%m-%dT%H:%M:%S') ${PROCNAME} (${fname}:${BASH_LINENO[0]}:${FUNCNAME[1]}) $@" | tee -a ${LOGFILE}
}
  mkdir -p /var/log/jamf-cis/
  touch ${LOGFILE}

## Main
Check_Flag=`launchctl list | grep -i -c auditd`

if [ ${Check_Flag} = 1 ]
then
    log "auditd running check"
    log "auditd running OK"
	echo ${Check_Flag}
else
    log "auditd running check"
    log "auditd running NG"
    log "auditd load"
	launchctl load -w /System/Library/LaunchDaemons/com.apple.auditd.plist
fi