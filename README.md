# Caretaker

A lightweight shell script utility for planning and executing multiple file
watchers that monitor your codebase for changes.

## Overview

Caretaker simplifies managing multiple file watchers through a simple configuration file.
It allows you to define different watch plans to monitor various parts of your project and
execute specific commands when changes are detected.

## Requirements

-   POSIX-compatible shell environment
-   A watcher such as [`watchexec`](https://github.com/watchexec/watchexec)
    installed and available in your PATH

## Installation

```sh
# Clone the repository
git clone https://github.com/merlindiavova/caretaker.git

# Link or copy the script to a directory in your PATH
ln -s "$(pwd)/caretaker/bin/caretaker" /usr/local/bin/caretaker
# OR
cp caretaker/bin/caretaker /usr/local/bin/caretaker
```

## Usage

```
caretaker [-hv] [-f <watch-plan>] <command>
DEBUG=1 caretaker [-hv] [-f <watch-plan>] <command>
TRACE=1 caretaker [-hv] [-f <watch-plan>] <command>
```

### Options

-   `-f <watch-plan>`: Specify the watch plan file (default: `./.watch.sh`)
-   `-h`: Display help message
-   `-v`: Display version information

### Commands

-   `init`: Initialize a default `.watch.sh` plan in the current directory
-   `watch`: Watch for changes using the plan (default if no command is given)

### Environment Variables

-   `TRACE`: Enables verbose shell mode (set -x)
-   `NO_COLOR`: Disables ANSI colors in output

## Getting Started

1. Initialize a watch plan in your project:

```sh
cd your-project
caretaker init
```

2. Edit the generated `.watch.sh` file to define your watch rules

3. Start the watchers:

```sh
caretaker
```

## Watch Plan Configuration

The `.watch.sh` file defines functions that create watch configurations. Each watcher
function must start with `watch_` to be recognized by caretaker.

Example watch plan:

```sh
#!/bin/sh -eu
# shellcheck disable=SC2034

watch_backend() {
    # Watcher (currently only "watchexec" is supported)
    watch_backend_watcher="watchexec"

    # Name of the watcher (used for logging)
    watch_backend_name="backend watcher"

    # Directories or files to watch for changes
    watch_backend_paths='src/backend'

    # File extensions to filter on
    watch_backend_exts='go'

    # Paths to ignore
    watch_backend_ignore_paths='vendor'

    # Command to run on change
    watch_backend_command="go test ./..."

    # Clear screen before running command
    watch_backend_clear_screen=true

    # Postpone first run until a file change (default: true)
    watch_backend_postpone_first_run=true

    # Signal to send to command on termination
    watch_backend_kill_signal='SIGINT'
}

watch_frontend() {
    watch_frontend_watcher="watchexec"
    watch_frontend_paths='src/frontend'
    watch_frontend_exts='js jsx css'
    watch_frontend_ignore_paths='node_modules'
    watch_frontend_command="npm test"
    watch_frontend_first_run=false
    watch_frontend_clear_screen=true
}
```

## Supported Watchers

Currently supported watchers:

-   `watchexec` - See [`watchexec`](https://github.com/watchexec/watchexec)

## License

MIT, see [LICENSE](COPYING)
