FILESYS1=''
FILESYS2=''

CHECK_FILESYS1=false
CHECK_FILESYS2=false


TO_SAVE=''
TO_BCKP=''

CHECK_TOSAVE=false
CHECK_TOBCKP=false

NAME=''
CHECK_NAME=false

DATE=$(date +%Y-%m-%d)


help_menu(){

	echo "menu de ayuda";
}


check_filesystems(){


	if mountpoint -q "$1" && mountpoint -q "$2";
	then
		return 0
		
	else
		return 1
	
	fi

}



do_backup(){

	local DIR_BACKUP=$1
	local DIR_SOURCE=$2
	local FILESYS_SOURCE=$3
	local FILESYS_BACKUP=$4
	local NAME=$5
	
	
	if check_filesystems "$FILESYS_SOURCE" "$FILESYS_BACKUP";
	then
		tar -cvzpf $DIR_BACKUP/$NAME-backup_$DATE.tar.gz $DIR_SOURCE;
	fi


}


while getopts 'a:b:c:d:n:h' option
do
	case "${option}"
	in
		a) FILESYS1="${OPTARG}"
		   CHECK_FILESYS1=true;;

		b) FILESYS2="${OPTARG}"
		   CHECK_FILESYS2=true;;
		
		c) TO_SAVE="${OPTARG}"
		   CHECK_TOSAVE=true;;

		d) TO_BCKP="${OPTARG}"
		   CHECK_TOBCKP=true;;
		
		n) NAME="${OPTARG}"
		   CHECK_NAME=true;;

		h) help_menu;;
	esac
done


if [ "$CHECK_TOSAVE" = true ] && [ "$CHECK_TOBCKP" = true ] && [ "$CHECK_FILESYS1" = true ] &&
[ "$CHECK_FILESYS2" = true ] && [ "$CHECK_NAME" = true ]; 
then
	do_backup "$TO_SAVE" "$TO_BCKP" "$FILESYS1" "$FILESYS2" "$NAME";

fi

