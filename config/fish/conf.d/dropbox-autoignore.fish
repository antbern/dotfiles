function __ignore_target_folders --on-variable PWD --description 'Ignore Rust target folders automatically'
	if test -d "$PWD/target"
		# make sure the file is not already ignored
		if attr -q -g com.dropbox.ignored "$PWD/target" | read x
			and test $x = 1
			# do nothing, already set
		else
			# if attr -g fails or it is set to 0, set the value to 1
			attr -q -s com.dropbox.ignored -V 1 "$PWD/target"
			echo "Ignored rust ./target"
		end
	end
end
