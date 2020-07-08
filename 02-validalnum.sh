#!/bin/bash
#Skrypt validalnum sprawdzający, czy wprowadzone dane zawierają wyłącznie litery i cyfry lub 
#czy wprowadzone dane składająja  sie z wilekich liter przecinków i kropek  lub
#czy w danych dopuszczone są cyfry spacje nawiasy i myślniki

validAlphaNum()
{
#Funkcja sprawdzająca argument. Zwraca 0, jeśli dane sa zgodne z założeniami, a 1 w przecwinym wypadku.

#Usuniecie wszystkich niedozwololonych znakow
validchars="$(echo $1 | sed -e 's/[^[:alnum:]]//g')"
#validchars="$(echo $1 | sed -e 's/[^[:upper:] ,.]//g')"  	#sed - edytor strumieniowy,  -e stosusjemy gdy przetwarzamy wiele polecen lub skrypt
#validchars="$(echo $1 | sed -e 's/[^- [:digit:]\(\)]//g')"	# '' stosujemy po przez cytowanie, s oznacza zmianę, /tutaj jaką, [^-poczatek wiersz
							  	# [:alnum:] - oznacza znaki alfanumerczyne, [:upper:] - duże litery
if [ "$validchars" = "$1" ] ; then				# [:digit:] cyfry od 0 do 9, w nasyzm przypadku to jest zmiana okreslonych liter na 
								#puste, g - to znaczy globalne
	return 0
else
	return 1
fi
}

echo -n "Podaj dane: "
read input


if ! validAlphaNum "$input" ; then
	echo "Dane mogą zawierać tylko litery lub cyfry." >&2
	exit 1
else
	echo "Dane poprawne"
fi

exit 0
