function _molecule_completion;
    set -l response (env _MOLECULE_COMPLETE=fish_complete COMP_WORDS=(commandline -cp) COMP_CWORD=(commandline -t) molecule);

    for completion in $response;
        set -l metadata (string split "," $completion);

        if test $metadata[1] = "dir";
            __fish_complete_directories $metadata[2];
        else if test $metadata[1] = "file";
            __fish_complete_path $metadata[2];
        else if test $metadata[1] = "plain";
            echo $metadata[2];
        end;
    end;
end;

# Custom completion for molecule -s (scenarios)
function __fish_molecule_scenarios
    # List all directories under the molecule folder
    ls molecule/ | grep -E '^([0-9]+_.*)$'
end

# Autocomplete molecule subcommands (e.g., test, verify, create, etc.)
complete --no-files --command molecule --arguments "(_molecule_completion)";

# Trigger autocompletion when molecule -s is used with any subcommand
complete -c molecule -s s -f -ra "(__fish_molecule_scenarios)"
