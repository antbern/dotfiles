function dropbox_ignore_toggle -d "Set dropbox to ignore the specified file(s) or directory(ies)"
    set -l key "com.dropbox.ignored"



    for target in $argv
        # try to get the value to see if this file is already ignored
        if attr -q -g $key $target
            echo "$target is already ignored, clearing ignored attribute..."
            attr -q -r $key $target 
        else
            echo "$target is not ignored, setting key value to ignore..."
            attr -q -s $key -V 1 $target
        end

    end
end