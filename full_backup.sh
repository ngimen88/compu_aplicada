FILESYS1=''
FILESYS2=''

CHECK_FILESYS1=false
CHECK_FILESYS2=false


DIR_BACKUP=''
DIR_SOURCE=''

CHECK_SOURCE=false
CHECK_DIR=false

NAME=''
CHECK_NAME=false

DATE=$(date +%Y-%m-%d)


help_menu(){

	echo -e "-a) Recibe direccion del filesystem de origen.\n 
-b) Recibe direccion del filesystem de destino.\n
-c) Recibe direccion del directorio donde se guardara el backup.\n
-d) Recibe direccion del directorio del que se hara un backup.\n
-n) Recibe el nombre del backup.\n
-h) Imprime el menu de ayuda."
}


check_directory(){

	local DIR=$1

	if [ -d "$DIR" ]
	then	
		return 0
	else 
		return 1
	fi
}



check_filesystem(){
	
	local FILESYS=$1

	if mountpoint -q "$FILESYS";
	then
		return 0
		
	else
		return 1
	
	fi

}



do_backup(){

	local DIR_BACKUP=$1
	local DIR_SOURCE=$2
	local FILESYS1=$3
	local FILESYS2=$4
	local NAME=$5
	
	
	if check_filesystem "$FILESYS1" && check_filesystem "$FILESYS2"
	   check_directory "$DIR_BACKUP" && check_directory "$DIR_SOURCE";
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
		
		c) DIR_BACKUP="${OPTARG}"
		   CHECK_BACKUP=true;;

		d) DIR_SOURCE="${OPTARG}"
		   CHECK_SOURCE=true;;
		
		n) NAME="${OPTARG}"
		   CHECK_NAME=true;;

		h) help_menu;;
	esac
done


if [ "$CHECK_BACKUP" = true ] && [ "$CHECK_SOURCE" = true ] && [ "$CHECK_FILESYS1" = true ] &&
[ "$CHECK_FILESYS2" = true ] && [ "$CHECK_NAME" = true ]; 
then
	do_backup "$DIR_BACKUP" "$DIR_SOURCE" "$FILESYS1" "$FILESYS2" "$NAME";

fi

