FILESYS1=''
FILESYS2=''

CHECK_FILESYS1=false
CHECK_FILESYS2=false


check_filesystems(){

	local DIR1=$1
	local DIR2=$2

	if mountpoint -q "$DIR1" && mountpoint -q "$DIR2";
	then
		echo "$DIR1 y $DIR2 montados correctamente";
	else
		echo "error";
	fi

}



while getopts 'a:b:' option
do
	case "${option}"
	in
		a) FILESYS1="${OPTARG}"
		   CHECK_FILESYS1=true;;

		b) FILESYS2="${OPTARG}"
		   CHECK_FILESYS2=true;;
	esac
done


if [ "$CHECK_FILESYS1" = true ] && [ "$CHECK_FILESYS2" = true ]; then
	check_filesystems "$FILESYS1" "$FILESYS2";
else
	echo "error en argumentos";
fi



