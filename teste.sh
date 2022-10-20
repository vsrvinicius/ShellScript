#!/bin/bash

echo "Digite o site:"
read site
echo "Wordlist?"
read lista
echo "Digite a extensão:"
read exte

for palavra in $(cat $lista)
do
resposta=$(curl -s -H "User-Agent: teste" -e robots.txt -o /dev/null -w "%{http_code}" $site/$palavra.$exte)
if [ $resposta == "200" ]
then
	echo "Arquivo encontrado: $site/$palavra.$exte"
fi
done
