#!/bin/bash

# Testando a transferência de zona para pegar informações

echo "Qual a url para pesquisa?"
read url

if [ "$url" == "" ]
then
	echo "Preencha a url!"
else
	echo "Verificando as informações"
	for server in $(host -t ns $url | cut -d " " -f 4);
	do
	echo "---------------------------------------"
        echo "-                                     -"
        echo "-      Procura pelo comando host      -"
        echo "-                                     -"
        echo "---------------------------------------"
        echo ""
	host -a $url $server
	echo "--------------------------------------"
	echo "-                                    -"
	echo "-      Procura pelo comando dig      -"
	echo "-                                    -"
	echo "--------------------------------------"
	echo ""
	dig -t axfr $url "@"$server
	done
fi
