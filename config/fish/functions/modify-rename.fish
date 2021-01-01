function modify-rename -d "rename a file to the last modified date"
    set -l format "%Y%m%d_%H%M%S"

    for src in $argv
        set -l extension (string split '.' "$src")[-1]
        set -l new_name (date -r $src +$format)
        set -l dst $new_name.$extension

        if test "$src" != "$dst"

            echo "Renaming $src to $dst"
            mv $src $dst        
        else
            echo "Skipped $src (already named correctly)"
        end
    end

end