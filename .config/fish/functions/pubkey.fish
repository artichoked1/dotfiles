function pubkey
    set -l keyfile ~/.ssh/id_ed25519.pub

    if test (count $argv) -gt 0
        set keyfile ~/.ssh/$argv[1]
    end

    if not test -f $keyfile
        echo "Public key not found: $keyfile"
        return 1
    end

    if type -q pbcopy
        cat $keyfile | pbcopy; and echo '=> Public key copied to clipboard (pbcopy).'
    else if type -q wl-copy; and set -q WAYLAND_DISPLAY
        cat $keyfile | wl-copy; and echo '=> Public key copied to clipboard (wl-copy).'
    else if type -q xclip
        cat $keyfile | xclip -selection clipboard; and echo '=> Public key copied to clipboard (xclip).'
    else if type -q xsel
        cat $keyfile | xsel --clipboard --input; and echo '=> Public key copied to clipboard (xsel).'
    else if type -q clip.exe
        cat $keyfile | clip.exe; and echo '=> Public key copied to clipboard (clip.exe).'
    else
        echo 'No clipboard tool found. Here is your public key:'
        cat $keyfile
    end
end

