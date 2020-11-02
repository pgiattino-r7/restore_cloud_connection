#!/bin/bash
#This script performs the "restore-cloud-connection" steps listed at the following URL:
#https://wiki.corp.rapid7.com/pages/viewpage.action?pageId=64415636
#Must be run as root
#Run 'tail -f /var/log/syslog | grep R7' concurrently for logging
#Created by Philip Giattino

echo "This script will restore the connection of the Nexpose Security Console to the Exposure Analytics instance it is currently paired to."

##### DECLARE VARIABLES

#find installation directory of Nexpose
NEXPATH=$(find / -name nsc.sh | sed 's/\(nsc\).*/\1/g')

#get current date for appending to nsc.xml during backup
current_date=$(date +"%Y-%m-%d")

##### DEFINE FUNCTIONS

#function to identify OS -- if not Linux, quit with error message
function check_os() {
	if [[ $OSTYPE != *linux-gnu* ]]; then
        	echo "System OS not Linux, cannot run script."
        	exit 1
	else logger "R7 - OS check passed, beginning re-pair."
	fi
}

#function to stop nexposeconsole service
function stop_nexposeconsole() {
	if systemctl show -p SubState --value nexposeconsole == "running" > /dev/null; then
        	systemctl stop nexposeconsole
		logger "R7 - Nexposeconsole service stopped."
		echo "nexposeconsole service stopped."
        fi
}

#function to backup nsc.xml
function backup_nsc() {
	echo "Copying nsc.xml to nsc.xml.bak-${current_date}."
	cp $NEXPATH/conf/nsc.xml $NEXPATH/conf/nsc.xml.bak-${current_date}
	logger "R7 - nsc.xml backed up into nsc.xml.bak-${current_date}."
}

#function to edit nsc.xml to change enabled and tourviewed fields to false
function edit_nsc() {
	echo "Editing nsc.xml."
	sed -i 's/<ExposureAnalytics enabled="true" tourViewed="true"/<ExposureAnalytics enabled="false" tourViewed="false"/g' $NEXPATH/conf/nsc.xml
	logger "R7 - ExposureAnalytics enabled and tourViewed values in nsc.xml set to false"
}

#function to remove exposure analytics files
function remove_files() {
	echo "Clearing pairing information in preparation of re-pairing."
	cd $NEXPATH/conf
	rm -f secrets.properties
	logger "R7 - Deleted $NEXPATH/conf/secrets.properties."
	cd ..
	rm -f exposure-analytics.sp
	logger "R7 - Deleted $NEXPATH/exosure-analytics.sp."
	rm -f service-provider-registry
	logger "R7 - Deleted $NEXPATH/service-provider-registry."
	cd ../nse
	rm -rf felix-cache
	logger "R7 - Deleted $NEXPATH/nse/felix-cache."
}

#check if services are running, if not, start services
function start_services() {
	echo "Restarting nexposeconsole service."
	systemctl start nexposeconsole
	logger "R7 - Nexposeconsole service started."
}

#function to prompt user to complete re-pairing instructions
function exit_message() {
	echo "Re-pair script finished successfully."
	echo "Please login to the Security Console once the services have finished loading, and complete the registration process."
}

#### MAIN
check_os
stop_nexposeconsole
backup_nsc
edit_nsc
remove_files
start_services
exit_message
exit
