#!/bin/sh -eu
# shellcheck disable=SC2034
#
# .watch.sh plan

watch_caretaker() {
	# Watcher (currently only "watchexec" is supported)
	watch_caretaker_watcher="watchexec"

	# Name of the watcher (used for logging, optional)
	watch_caretaker_name="format caretaker with shfmt"

	# Directories or files to watch for changes (space-separated)
	watch_caretaker_paths='bin'

	# File extensions to filter on (space-separated)
	watch_caretaker_exts=''

	# Paths to ignore (space-separated)
	watch_caretaker_ignore_paths='.editorconfig README.md'

	# Command to run on change
	watch_caretaker_command="shfmt -p -d -i 0 -bn bin/caretaker"

	# Clear screen before running command
	watch_caretaker_clear_screen=true

	# Signal to send to command on termination
	watch_caretaker_kill_signal='SIGINT'
}

# repeat function run multiple plans
