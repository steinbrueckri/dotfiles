complete -c multipass -n "__fish_use_subcommand" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_use_subcommand" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_use_subcommand" -f -a "delete" -d 'Delete instances'
complete -c multipass -n "__fish_use_subcommand" -f -a "exec" -d 'Run a command on an instance'
complete -c multipass -n "__fish_use_subcommand" -f -a "find" -d 'Display available images to create instances from'
complete -c multipass -n "__fish_use_subcommand" -f -a "get" -d 'Get a configuration setting'
complete -c multipass -n "__fish_use_subcommand" -f -a "help" -d 'Display help about a command'
complete -c multipass -n "__fish_use_subcommand" -f -a "info" -d 'Display information about instances'
complete -c multipass -n "__fish_use_subcommand" -f -a "launch" -d 'Create and start an Ubuntu instance'
complete -c multipass -n "__fish_use_subcommand" -f -a "list" -d 'List all available instances'
complete -c multipass -n "__fish_use_subcommand" -f -a "mount" -d 'Mount a local directory in the instance'
complete -c multipass -n "__fish_use_subcommand" -f -a "purge" -d 'Purge all deleted instances permanently'
complete -c multipass -n "__fish_use_subcommand" -f -a "recover" -d 'Recover deleted instances'
complete -c multipass -n "__fish_use_subcommand" -f -a "restart" -d 'Restart instances'
complete -c multipass -n "__fish_use_subcommand" -f -a "set" -d 'Set a configuration setting'
complete -c multipass -n "__fish_use_subcommand" -f -a "shell" -d 'Open a shell on a running instance'
complete -c multipass -n "__fish_use_subcommand" -f -a "start" -d 'Start instances'
complete -c multipass -n "__fish_use_subcommand" -f -a "stop" -d 'Stop running instances'
complete -c multipass -n "__fish_use_subcommand" -f -a "suspend" -d 'Suspend running instances'
complete -c multipass -n "__fish_use_subcommand" -f -a "transfer" -d 'Transfer files between the host and instances'
complete -c multipass -n "__fish_use_subcommand" -f -a "umount" -d 'Unmount a directory from an instance'
complete -c multipass -n "__fish_use_subcommand" -f -a "version" -d 'Show version details'
complete -c multipass -n "__fish_seen_subcommand_from delete" -d 'Names of instances to delete' -r
complete -c multipass -n "__fish_seen_subcommand_from delete" -l all -d 'Delete all instances'
complete -c multipass -n "__fish_seen_subcommand_from delete" -s p -l purge -d 'Purge instances immediately'
complete -c multipass -n "__fish_seen_subcommand_from delete" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from delete" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from exec" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from exec" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from find" -d ' An optional value to search for in [<remote:>]<string>' -r
complete -c multipass -n "__fish_seen_subcommand_from find" -l format -d 'Output list in the requested format.Valid formats are: table (default), json, csv and yaml'
complete -c multipass -n "__fish_seen_subcommand_from find" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from find" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from get" -d ' Path to the setting whose configured value should be obtained.' -r
complete -c multipass -n "__fish_seen_subcommand_from get" -l raw -d 'Output in raw format. For now, this affects only the representation of empty values (i.e. "" instead of "<empty>").'
complete -c multipass -n "__fish_seen_subcommand_from get" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from get" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from help" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from help" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from info" -d ' Names of instances to display information about' -r
complete -c multipass -n "__fish_seen_subcommand_from info" -l all -d 'Display info for all instances'
complete -c multipass -n "__fish_seen_subcommand_from info" -l format -d 'Output info in the requested format. Valid formats are: table (default), json, csv and yaml'
complete -c multipass -n "__fish_seen_subcommand_from info" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from info" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from launch" -s c -l cpus -d 'Number of CPUs to allocate. Minimum: 1, default: 1.' -r
complete -c multipass -n "__fish_seen_subcommand_from launch" -s m -l mem -d 'Amount of memory to allocate. Positive integers, in bytes, or with K, M, G suffix. Minimum: 128M, default: 1G.' -r
complete -c multipass -n "__fish_seen_subcommand_from launch" -s d -l disk -d 'Disk space to allocate. Positive integers, in bytes, or with K, M, G suffix. Minimum: 512M, default: 5G.' -r
complete -c multipass -n "__fish_seen_subcommand_from launch" -s n -l name -d 'Name for the instance. If it is primary (the configured primary instance name), the user home directory is mounted inside the newly launched instance, in Home.' -r
complete -c multipass -n "__fish_seen_subcommand_from launch" -d 'Optional image to launch. If omitted, then the default Ubuntu LTS will be used.' -r
complete -c multipass -n "__fish_seen_subcommand_from launch" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from launch" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from list" -l format -d 'Output list in the requested format. Valid formats are: table (default), json, csv and yaml'
complete -c multipass -n "__fish_seen_subcommand_from list" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from list" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from mount" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from mount" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from purge" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from purge" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from recover" -d 'Names of instances to recover' -r
complete -c multipass -n "__fish_seen_subcommand_from recover" -l all -d 'Recover all deleted instances'
complete -c multipass -n "__fish_seen_subcommand_from recover" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from recover" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from restart" -d 'Names of instances to restart. If omitted, and without the --all option, primary will be assumed.' -r
complete -c multipass -n "__fish_seen_subcommand_from restart" -l all -d 'Recover all deleted instances'
complete -c multipass -n "__fish_seen_subcommand_from restart" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from restart" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from set" -d 'A key-value pair. The key specifies a path to the setting to configure. The value is its intended value.' -r
complete -c multipass -n "__fish_seen_subcommand_from set" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from set" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from shell" -d 'Name of the instance to open a shell on. If omitted, primary (the configured primary instance name) will be assumed. If the instance is not running, an attempt is made to start it (see `start` for more info).' -r
complete -c multipass -n "__fish_seen_subcommand_from shell" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from shell" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from start" -d 'Names of instances to start. If omitted, and without the --all option, primary (the configured primary instance name) will be assumed. If primary does not exist but is included in a successful start command (either implicitly or explicitly), it is launched automatically (see `launch` for more info).' -r
complete -c multipass -n "__fish_seen_subcommand_from start" -l all -d 'Start all instances'
complete -c multipass -n "__fish_seen_subcommand_from start" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from start" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from stop" -s t -l time -d 'Time from now, in minutes, to delay shutdown of the instance' -r
complete -c multipass -n "__fish_seen_subcommand_from stop" -s c -l cancel -d 'Cancel a pending delayed shutdown' -r
complete -c multipass -n "__fish_seen_subcommand_from stop" -d 'Names of instances to stop. If omitted, and without the --all option, primary will be assumed' -r
complete -c multipass -n "__fish_seen_subcommand_from stop" -l all -d 'Stop all instances'
complete -c multipass -n "__fish_seen_subcommand_from stop" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from stop" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from suspend" -d 'Names of instances to suspend. If omitted, and without the --all option, primary will be assumed.' -r
complete -c multipass -n "__fish_seen_subcommand_from suspend" -l all -d 'Suspend all instances'
complete -c multipass -n "__fish_seen_subcommand_from suspend" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from suspend" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from transfer" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from transfer" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from umount" -d 'Mount points, in <name>[:<path>] format, where <name> are instance names, and optional <path> are mount points. If omitted, all mounts will be removed from the named instances.' -r
complete -c multipass -n "__fish_seen_subcommand_from umount" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from umount" -s V -l version -d 'Prints version information'
complete -c multipass -n "__fish_seen_subcommand_from version" -s h -l help -d 'Prints help information'
complete -c multipass -n "__fish_seen_subcommand_from version" -s V -l version -d 'Prints version information'
