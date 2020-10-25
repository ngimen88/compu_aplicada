

DATE=$(date +%Y-%m-%d);


backup_etc_varlog(){

if mountpoint -q /u03 && mountpoint -q /; then
		
	tar -cvzpf /u03/etc_bckp_$DATE.tar.gz /etc;
	
	tar -cvzpf /u03/varlog_bckp_$DATE.tar.gz /var/log;
	
	echo "/etc y /var/log empaquetados en /u03.";
else

	echo "[ERROR]";

fi

}

backup_u01_u02(){

if mountpoint -q /u01 && mountpoint -q /u02 && mountpoint -q /u03; then

	
	tar -cvzpf /u03/u01_bckp_$DATE.tar.gz /u01;

	tar -cvzpf /u03/u02_bckp_$DATE.tar.gz /u02;

	echo "/u01 y /u02 empaquetados en /u03.";
else

	echo "[ERROR]";

fi
}



if declare -f "$1" > /dev/null; then

	"$@"
else

	echo "$1 Argumento invalido.";
	exit 1;

fi
