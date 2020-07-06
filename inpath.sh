#!/bin/bash

#Skrypt inpath sprawdzający, czy dany program jest poprawny sam w sobie,
#czy też znajduje się w katalogach zapisanych w zmiennej PATH

echo "Zostałem wywołany z: $_"

name=`ps -o ppid:1= -p $$` #komenda pokazujaca numer procecu pod którym kryje się terminal

p1=$$  #numer procesu aktualnego skryptu

let p3=p1-p2 #roznica procesu skryptu 1 i procesu skryptu 2 wywolujacego 1 

if [ "$$" > "$name" ] ; then #jesli numer procesu skryptu jest wiekszy nz procesu termnalu
	if [ "$p3" = "1" ] ; then  #roznica prosceos ronwa 1
		echo "To jest uruchomione z innego skryptu"
	else
		echo "To jest uruchomione z linii polecen"
	fi
fi

if [ "$p2" != "" ] ; then  #jesli porces sktrptu 2 nie jest pusta,, to usun wyexportowany numeer procesu
	rm $p2
fi



in_path()
{

#Funkcja usilujaca odnalezc program na podstawie jego nazwy i zmiennej PATH.
#Zwraca 0 jezeli program istnieje i jest plikiem wykonywalnym albo 1 w przeciwnym wypadku.
#Zwroc owage, ze tymaczasowo zmieniany jest separator IFS ale jego pierwotna wartość jest
#przywracana na koncu funkcji 

cmd="$1"	ourpath="$2"	result=1
oldIFS=$IFS	IFS=":"

for directory in $ourpath
do
	if [ -x "$directory/$cmd" ]  ; then
		result=0
	fi
done

IFS=$oldIFS
return $result
}


checkForCmdInPath()
{

var=$1

if [ "$var" != "" ] ; then
	if [ "${var:0:1}" = "/" ] ; then
		if [ ! -x "$var" ] ; then 
			return 1
		fi
	elif ! in_path $var $PATH ; then
			return 2
	fi
fi
} 

if [ $# -ne 1 ] ; then
	echo "Uzycie: $0 polecenie" >&2  ; exit 1
fi

checkForCmdInPath "$1" 
case $? in
	0 ) echo "$1 znajduje sie w katalogach zmiennej path."	;;
	1 ) echo "$1 nie istnieje i nie jest to plik wykonywalny." ;;
	2 ) echo "$1 nie znajduje sie w katalogach zmiennej path." ;;


esac

exit 0
