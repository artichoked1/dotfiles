function is-git-dirty
    git rev-parse --is-inside-work-tree >/dev/null 2>/dev/null
    if test $status -ne 0
        echo false
        return 1
    end

    git diff-files --no-ext-diff --quiet
    if test $status -eq 1
        echo true
        return 0
    end

    git diff-index --no-ext-diff --quiet --cached HEAD
    if test $status -eq 1
        echo true
        return 0
    end

    set untracked (command git ls-files -o --exclude-standard ^/dev/null 2>/dev/null)
    if test -n "$untracked"
        echo true
        return 0
    end

    echo false
    return 1
end
