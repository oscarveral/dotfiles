#!/usr/bin/env bash

# Set options.
set -o errexit  
set -o nounset
set -o pipefail

# Retrieve the script name and canonical path.
get_dir $BASH_SOURCE

# Set selecteable options dir names on this script directory.
readonly DIRS=$(find $DIR -maxdepth 1 -type d -exec basename {} \; | grep -v "$(basename $DIR)")

# Set a flag to control the loop.
SHOULD_LOOP=true
MACHINE_SELECTED="none"

# Loop until the user selects the option to quit.
clear
while [ "$SHOULD_LOOP" == "true" ]
do
	echo "Select a machine:"
	# Select a directory.
	select dir in $DIRS "Quit"
	do
		case $dir in
			"Quit")
				SHOULD_LOOP=false
				;;
			*)
				# Check if the selected option is not empty.
				if [ ! -z "$dir" ] 
				then
					MACHINE_SELECTED=$dir
					SHOULD_LOOP=false
				fi
				;;
		esac
		break
	done
	clear
done

# Check if the user selected a machine.
if [ "$MACHINE_SELECTED" == "none" ]
then
	log "No machine selected. Exiting..."
	panic $E_NOMACHINE
fi

log "Selected machine: $MACHINE_SELECTED"