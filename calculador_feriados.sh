
#


INAMOVIBLES=('01-01' '02-24' '02-25' '03-23' '03-24' '03-31' 
'04-10' '05-01' '05-25' '06-20' '07-09' '07-10' '12-07' '12-08' '12-25')

INAMOVIBLES_DSCRP=('Año nuevo' 'Carnaval' 'Carnaval' 'Turistico' 'Memoria por la verdad y justicia' 'Veteranos y caidos en Malvinas' 'Pascuas' 'Dia del trabajador' 'Revolucion de mayo' 
'Paso a la inmortalidad del General Manueal Belgrnao' 'Dia de la independencia' 'Turistico' 
'Turistico' 'Inmaculada concepcion de Maria' 'Navidad')

FERIADOS_LUNESCERCANO=('06-17' '10-12' '11-20')

FERIADOS_TERCERLUNES=('08-17')

LUNES_CERCANO_DSCR=('Guemes' 'Dia del Respeto a la diversidad cultural' 'Dia de la Sobernia') 

TERCER_LUNES_DSCR=('Paso a la inmortalidad del General Jose de San Martin')

FERIADO_CHECK=false

LUNESCERCANO_CHECK=false

TERCERLUNES_CHECK=false

INDEX=0

FECHA=$1

YEAR=$(date +%Y)

FECHA_COMPLETA="$YEAR-$FECHA"

FECHA_AFESTEJAR=''

tercer_lunes(){
	
	MES=$1

	for D in 01 02 03 04 05 06; do

		[ "`date --date \"$YEAR-$MES-$D\" +'%w'`" -eq 1 ] && DIA="$YEAR-$MES-$D"

	done

	FTL=`date --date "$DIA 14 days" +'%Y-%m-%d'`

}


esLaborable(){
	
	local FECHA=$1

	local FECHA_NUMSEM=$(date --date=$FECHA_COMPLETA +%u)

	for i in "${!FERIADOS_LUNESCERCANO[@]}"; do

		if [[ "${FERIADOS_LUNESCERCANO[$i]}" = "${FECHA}" ]]; then

			INDEX=$i
			
			if [[ ${FECHA_NUMSEM} -eq 1 ]]; then
				
				FECHA_AFESTEJAR=$FECHA_COMPLETA
				LUNESCERCANO_CHECK=true
		
			elif [[ ${FECHA_NUMSEM} -eq 2 ]]; then

				FECHA_AFESTEJAR=$(date --date="$FECHA_COMPLETA - 1 days" +%Y-%m-%d)
				LUNESCERCANO_CHECK=true
		

			elif [[ ${FECHA_NUMSEM} -eq 3 ]]; then

				FECHA_AFESTEJAR=$(date --date="$FECHA_COMPLETA - 2 days" +%Y-%m-%d)
				LUNCESCERCANO_CHECK=true

			elif [[ ${FECHA_NUMSEM} -eq 4 ]]; then

				FECHA_AFESTEJAR=$(date --date="$FECHA_COMPLETA + 4 days" +%Y-%m-%d)
				LUNESCERCANO_CHECK=true

			elif [[ ${FECHA_NUMSEM} -eq 5 ]]; then


				FECHA_AFESTEJAR=$(date --date="$FECHA_COMPLETA + 3 days" +%Y-%m-%d)
				LUNESCERCANO_CHECK=true
			fi

		fi
	done


	for i in "${!FERIADOS_TERCERLUNES[@]}"; do

		if [[ "${FERIADOS_TERCERLUNES[$i]}" = "${FECHA}" ]]; then
			tercer_lunes 08			
			INDEX=$i		
			TERCERLUNES_CHECK=true
		fi

	done


	for i in "${!INAMOVIBLES[@]}"; do

		
		if [[ "${INAMOVIBLES[$i]}" = "${FECHA}" ]]; then
		       FERIADO_CHECK=true;
		       INDEX=$i;
		      
	       	fi	       

	done

}


esLaborable "$FECHA"

if [ "$TERCERLUNES_CHECK" = true ]; then

	echo "$FECHA Se festejara el $FTL: ${TERCER_LUNES_DSCR[$INDEX]}"
fi



if [ "$LUNESCERCANO_CHECK" = true ]; then

	if [ "$FECHA_COMPLETA" = "$FECHA_AFESTEJAR" ]; then

		echo "$FECHA: ${LUNES_CERCANO_DSCR[$INDEX]}"

	else
	
		echo "$FECHA se festejara el $FECHA_AFESTEJAR: ${LUNES_CERCANO_DSCR[$INDEX]}"
	fi
fi


if [ "$FERIADO_CHECK" = true ]; then

	echo "${INAMOVIBLES[$INDEX]}-$YEAR: ${INAMOVIBLES_DSCRP[$INDEX]}"
fi


if [ "$TERCERLUNES_CHECK" = false ] && [ "$FERIADO_CHECK" = false ] && 
[ "$LUNESCERCANO_CHECK" = false ]; then

	echo "$FECHA no es un feriado."

fi
