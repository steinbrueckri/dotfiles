function __fish_postexec_molecule_notify --on-event fish_postexec
    # Check if the last command was a Molecule command and failed
    if string match -q "molecule*" (commandline -opc)
        if test $status -ne 0
            # Display popup notification
            osascript -e 'display notification "Molecule command failed!" with title "Molecule Alert"'
            # Play audio notification (system sound)
            afplay /System/Library/Sounds/Ping.aiff -v 7
        end
    end
end
