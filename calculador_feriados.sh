
INAMOVIBLES=('01-01' '24-02' '25-02' '23-03' '24-03' '31-03' 
'10-04' '01-05' '25-05' '20-06' '09-07' '10-07' '07-12' '08-12' '25-12')

INAMOVIBLES_DSCRP=('Año nuevo' 'Carnaval' 'Carnaval' 'Turistico' 'Memoria por la verdad y justicia' 'Veteranos y caidos en Malvinas' 'Pascuas' 'Dia del trabajador' 'Revolucion de mayo' 
'Paso a la inmortalidad del General Manueal Belgrnao' 'Dia de la independencia' 'Turistico' 
'Turistico' 'Inmaculada concepcion de Maria' 'Navidad')

FERIADO_CHECK=false

INDEX=0

FECHA=$1

YEAR=$(date +%Y)

esLaborable(){
	
	local FECHA=$1
	
	for i in "${!INAMOVIBLES[@]}"; do

		
		if [[ "${INAMOVIBLES[$i]}" = "${FECHA}" ]]; then
		       FERIADO_CHECK=true;
		       INDEX=$i;
	       	fi	       

	done

}




esLaborable "$FECHA"



if [ "$FERIADO_CHECK" = true ]; then

	echo "${INAMOVIBLES[$INDEX]}-$YEAR: ${INAMOVIBLES_DSCRP[$INDEX]}";

else
	echo	"$FECHA no es un feriado.";
fi

