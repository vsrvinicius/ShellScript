#!/bin/bash
echo "----------------------------------------------------------------"
echo ">       << Programa executado para scan e parsing >>"
echo "> Data da execução: "&(date)
echo "> Usuário que executou: "$(whoami)
echo "----------------------------------------------------------------"
echo ""
echo "Qual a rede desejada?"
read ip
# linha 10
if [ "$ip" == "" ]
then
	echo "Primeiro IF"
	echo "O argumento não foi preenchido corretamente!!!"
	echo "Exemplo: 192.168.0."
else
	echo "Segundo IF"
	for fn in {1..254};
	do
	hping3 -S -p 13 -c 1 $ip.$fn 2> /dev/null | grep "flags=SA"
	hping3 -S -p 37 -c 1 $ip.$fn 2> /dev/null | grep "flags=SA"
	hping3 -S -p 30000 -c 1 $ip.$fn 2> /dev/null | grep "flags=SA"
	hping3 -S -p 3000 -c 1 $ip.$fn 2> /dev/null | grep "flags=SA"
	open=$(nmap -Pn -p 80 $ip.$fn | cut -d\/ -f 2 | cut -d " " -f 2 | grep open)
#	char=$(echo -n "$open" | wc -c)
	if [ "$open" > '0' ]
	then
		echo "O ip "$ip.$fn" está com a porta 1337 aberta."
		hping3 -S -p 1337 -c 1 $ip.$fn
	else
		echo "" >/dev/null
	fi
	done
fi

