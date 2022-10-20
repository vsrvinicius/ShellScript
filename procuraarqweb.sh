#!/bin/bash
echo "Esse programa procura por arquivos de um site no google."
echo "Qual o site para pesquisa de extensão de arquivos:"
read site
echo "Quantas linhas de pesquisa você deseja ?"
read qtd

exte=('php' 'aspx' 'asp' 'txt' 'pdf' 'doc' 'txt')

for x in ${exte[@]};
do
    lynx -dump "http://www.google.com.br/search?num=$qtd&q=site:$site+ext$exte" | cut -d "=" -f2 | grep ".$x" | egrep -v "site|google" | sed s'/...$//'g
    sleep 2
done


# site:businesscorp.com.br intext:key >> https://www.google.com/search?q=site%3Abusinesscorp.com.br+intext%3Akey
# site:businesscorp.com.br ext:txt >> https://www.google.com/search?q=site%3Abusinesscorp.com.br+ext%3Aphp