#!/bin/bash
# Note: Use bash instead of sh to properly source env vars
cd "$( dirname "$( realpath "$0" )" )"

# Force sourcing of all vars
set -a
source .env

if [ "${AntiCrash}" == true ]
then
Pid=;

echo "[I] AntiCrash is enabled."

AppRestart(){
	kill -n9 "${Pid}"
	AppBackground
}

AppBackground(){
	echo "[I] Restarting process..."
	cp ./tg-index.session.bak ./tg-index.session
	python3 -m app &
	Pid="$!"
}
AppBackground

Url="http://localhost:${PORT}"
MinSleep=20
AddSleep=10

sleep "${MinSleep}"

while true
do
	Html="$(curl -s "${Url}")"
	Chats="$(echo "${Html}" | grep '<a href="' | grep 'title="')"
	NoMsg=""
	Sleep="${MinSleep}"
	if [ -n "${Chats}" ]
	then
		for Token in ${Chats}
		do
			if [ -n "$(echo "${Token}" | grep 'href="')" ] #'
			then
				Sleep="$(($Sleep + $AddSleep))"
				Chat="$(echo "${Token}" | cut -d '"' -f 2)" #'
				NoMsg="$(curl -s "${Url}${Chat}" | grep '<p data-text="No message to display!"')"
				[ -n "${NoMsg}" ] && AppRestart
			fi
		done
	elif [ -z "${Html}" ] || [ -n "${NoMsg}" ]
	then AppRestart
	fi
	sleep "${Sleep}"
done

else python3 -m app
fi
