#!/usr/bin/env bash 

# Set options.
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

# Set variables.
readonly E_OK=0
readonly E_BADARGS=85
readonly E_USERABORT=86
readonly E_FFILE=87
readonly E_NOMACHINE=90

# Define functions.

# --------------------------------------------------------- #
# log ()                                         			#
# Writes an entry on the log file.             				#
# Parameter: $1 - Message to write.							#
# --------------------------------------------------------- #
log () {
	# Log message.
	printf "%s: %s\n" "$(date)" "$1" >> $LOGFILE
}

# --------------------------------------------------------- #
# get_dir ()                                         		#
# Retrieves the script name and canonical path.             #
# Parameter: $1 - $BASH_SOURCE expected.					#
# Export: $SOURCE and $DIR with the script name and path.	#
# --------------------------------------------------------- #
get_dir() {
	# Get current script.
	SOURCE="$1"
	while [ -L "$SOURCE" ]; do # Resolve $SOURCE until the file is no longer a symlink.
		DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
		SOURCE=$(readlink "$SOURCE")
		# If $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located..
		[[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE
	done
	DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
}

# --------------------------------------------------------- #
# panic ()                                         			#
# Ends the execution gracefully             				#
# Parameter: $1 - Exit code.								#
# --------------------------------------------------------- #
panic () {
	# Log message.
	log "Installation process end."
	log " ---------------------------- "
	log " "
	exit $1
}

# Obtain $SOURCE y $DIR.
get_dir $BASH_SOURCE

# Set log file on current directory.
LOGFILE="$DIR/install.log"

# Get params to check if debug mode is enabled. No getopt here.
while [ $# -gt 0 ]; do
	case "$1" in
		-d|--debug)
			# Log on debug mode.
			set -o xtrace 
			;;
		-f|--file)
			# Log on specific existing file.
			shift
			LOGFILE=$1
			if [ ! -f $LOGFILE ]; then
                echo "Error: Supplied file doesn't exist!"
                exit $E_FFILE
            fi
			;;
		*)
			echo "Unknown parameter passed: $1"
			exit $E_BADARGS
			;;
	esac
	shift
done

# Create log file if it doesn't exist.
if [ ! -f $LOGFILE ]; then
	touch $LOGFILE
fi

# Set trap to catch user abort.
trap 'panic $E_USERABORT' SIGINT

log " "
log " ---------------------------- "
log "Starting installation process."

# Select a machine for installation process.
source $DIR/selection.sh
# Start installation process.
source $DIR/$MACHINE_SELECTED/install.sh

log "Installation process end."
log " ---------------------------- "
log " "

exit $E_OK