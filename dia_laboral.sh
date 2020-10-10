echo "hoy es es: $(date +"%D")"
day=$(date +"%u")

feriado=false

actual_day_month=$(date +"%d-%m")

feriados=('01-01' '24-02' '25-02' '23-03' '24-03' '31-03' 
'09-04' '10-04' '15-04' '16-04' '24-04' '01-05' '24-05' '25-05' 
'15-06' '20-06' '09-07' '10-07' '17-08' '12-10' '23-11' '07-12' '08-12' '25-12')


for i in "${feriados[@]}"; do

	if [ "$actual_day_month" == "$i" ]; then
		
		feriado=true

	fi

done

if [ "$feriado" = true ]; then

	echo "Es feriado :)"

else

	echo "No es feriado :("

fi



if ((day > 5)); then

	echo "Fin de semana"

else

	echo "Dia de semana"

fi


