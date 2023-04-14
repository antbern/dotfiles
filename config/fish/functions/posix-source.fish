# From https://lewandowski.io/2016/10/fish-env/
# Allows one to source a posix-formatted .env file with VAR=VALUE entries into global environment variables
function posix-source
	for i in (cat $argv)
		set arr (echo $i |tr = \n)
  		set -gx $arr[1] $arr[2]
	end
end