#!/bin/bash
# lista de agent >> https://developer.mozilla.org/pt-BR/docs/Web/HTTP/Headers/User-Agent

echo "--------------------------------------------------------"
echo ""
echo "  *****************************************************"
echo " ***          Programa para Web Recon              ***"
echo " *****************************************************"
echo ""
echo " Exemplo para preenchimento                            "
echo " Qual o site será testado: seusite.com.br"
echo " Qual o nome da Wordlist que será usada? wordlist.txt (Esse arquivo exite)"
echo "-------------------------------------------------------" 
echo ""

agent=('teste') # 'Mozilla/5.0' 'Opera/9.80' 'Safari/604.1' 'Agent_User' 'Chrome/51.0'>> outros agentes para teste

echo "Qual o site que será testado ?"
read site1
if [ "$site1" == "" ]
then
	echo "Preencha o site antes de prosseguir!"
	echo "Exemplo: joao.com.br"
else
	echo ""
	echo "Qual o nome da Wordlist que será usada?"
	read word
	if [ "$word" == "" ]
	then
		echo "Informe o nome da wordlist ou o caminho completo dela."
		echo "No diretório atual " $pwd "temos as seguintes wordlists"
		ls | grep "txt"
		echo ""
		echo " Outras podem ser encontradas no diretório /usr/share/wordlists "
		ls /usr/share/wordlists # | grep "txt" | cut -d " " -f 10
	else
	echo ""
	echo "Deseja pesquisar com os user agent dos navegadores? 1 - Sim / 2 - Não"
	read usragent
		if [ "$usragent" == "1" ]
		then
			echo "Realizando a Pesquisa Com Agente definido!!!"
			for x in ${agent[@]};
			do
				total=0
				totalarq=0
				echo ""
				echo "--------------------------------------"
				echo "Resultado com o agente: $x"
				echo "--------------------------------------"
				echo ""
				hsite="https://www.$site1"
				ssite="$site1"
				respostahttps=$(curl -s -H "User-Agent: $x" -e robots.txt -o /dev/null -w "%{http_code}" $hsite)
				resposta1=$(curl -s -H "User-Agent: $x" -e robots.txt -o /dev/null -w "%{http_code}" $ssite)
				echo $hsite
				echo $ssite
				if [ $respostahttps == "200" ]
				then
					site=$hsite
					echo "Site com criptografia."
					echo "Diretório encontrado: $site"
					let total+=1;
					for arquivo in $(cat $word);
					do
						rarquivo=$(curl -s -H "User-Agent: $x" -e robots.txt -o /dev/null -w "%{http_code}" $site/$arquivo)
						if [ $rarquivo == "200" ]
						then
							echo "	-> Arquivo encontrado: $site/$arquivo"
							echo "	-> Arquivo encontrado: $site/$arquivo" >> $site.txt
							let totalarq+=1;
						fi
					done
					for palavra in $(cat $word);
					do
						resposta=$(curl -s -H "User-Agent: $x" -e robots.txt -o /dev/null -w "%{http_code}" $site/$palavra/)
						if [ $resposta == "200" ]
						then
							echo "Diretório encontrado: $site/$palavra"
							let total+=1;
							for arquivo in $(cat $word);
							do
								rarquivo=$(curl -s -H "User-Agent: $x" -e robots.txt -o /dev/null -w "%{http_code}" $site/$palavra/$arquivo)
								if [ $rarquivo == "200" ]
								then
									echo "	-> Arquivo encontrado: $site/$palavra/$arquivo"
									echo "	-> Arquivo encontrado: $site/$arquivo" >> $site.txt
									let totalarq+=1;
								fi
							done
						fi
					done
						echo "Total de sites encontrados: $total"
						echo "Total de arquivos encontrados: $totalarq"
				elif [ $resposta1 == "200" ]
				then
					site=$ssite
					echo "Site sem criptografia."
					echo "Diretório encontrado: $site"
					echo "Diretório encontrado: $site" >> $site1.txt
					let total+=1;
					for arquivo in $(cat $word);
					do
						rarquivo=$(curl -s -H "User-Agent: $x" -e robots.txt -o /dev/null -w "%{http_code}" $site/$arquivo)
						if [ $rarquivo == "200" ]
						then
							echo "	-> Arquivo encontrado: $site/$arquivo"
							let totalarq+=1;
						fi
					done
					for palavra in $(cat $word);
					do
						resposta=$(curl -s -H "User-Agent: $x" -e robots.txt -o /dev/null -w "%{http_code}" $site/$palavra/)
						if [ $resposta == "200" ]
						then
							echo "Diretório encontrado: $site/$palavra"
							let total+=1;
							for arquivo in $(cat $word);
							do
								rarquivo=$(curl -s -H "User-Agent: $x" -e robots.txt -o /dev/null -w "%{http_code}" $site/$palavra/$arquivo)
								if [ $rarquivo == "200" ]
								then
									echo "	-> Arquivo encontrado: $site/$palavra/$arquivo"
									let totalarq+=1;
								fi
							done
						fi
					done
						echo "Total de sites encontrados: $total"
						echo "Total de arquivos encontrados: $totalarq"
				else
					echo "Site não existe!!!"
				fi
			done
		elif [ "$usragent" == "2" ]
		then
		echo "Realizando a Pesquisa Sem Agente definido!!!"
		total=0
		totalarq=0
		hsite="https://www.$site1"
		ssite="$site1"
		respostahttps=$(curl -s -e robots.txt -o /dev/null -w "%{http_code}" $hsite)
		resposta1=$(curl -s -e robots.txt -o /dev/null -w "%{http_code}" $ssite)
			if [ $respostahttps == "200" ]
			then
				site=$hsite
				echo "Site com criptografia."
				echo "Diretório encontrado: $site"
				echo "Diretório encontrado: $site" >> $site1.txt
				let total+=1;
				for arquivo in $(cat $word);
					do
						rarquivo=$(curl -s -e robots.txt -o /dev/null -w "%{http_code}" $site/$arquivo)
						if [ $rarquivo == "200" ]
						then
							echo "	-> Arquivo encontrado: $site/$arquivo"
							let totalarq+=1;
						fi
					done
					for palavra in $(cat $word);
					do
						resposta=$(curl -s -e robots.txt -o /dev/null -w "%{http_code}" $site/$palavra/)
						if [ $resposta == "200" ]
						then
							echo "Diretório encontrado: $site/$palavra"
							let total+=1;
							for arquivo in $(cat $word);
							do
								rarquivo=$(curl -s -e robots.txt -o /dev/null -w "%{http_code}" $site/$palavra/$arquivo)
								if [ $rarquivo == "200" ]
								then
									echo "	-> Arquivo encontrado: $site/$palavra/$arquivo"
									let totalarq+=1;
								fi
							done
						fi
					done
						echo "Total de sites encontrados: $total"
						echo "Total de arquivos encontrados: $totalarq"
				elif [ $resposta1 == "200" ]
				then
					site=$ssite
					echo "Site sem criptografia."
					echo "Diretório encontrado: $site"
					echo "Diretório encontrado: $site" >> $site1.txt
					let total+=1;
					for arquivo in $(cat $word);
					do
						rarquivo=$(curl -s -e robots.txt -o /dev/null -w "%{http_code}" $site/$arquivo)
						if [ $rarquivo == "200" ]
						then
							echo "	-> Arquivo encontrado: $site/$arquivo"
							let totalarq+=1;
						fi
					done
					for palavra in $(cat $word);
					do
						resposta=$(curl -s -e robots.txt -o /dev/null -w "%{http_code}" $site/$palavra/)
						if [ $resposta == "200" ]
						then
							echo "Diretório encontrado: $site/$palavra"
							let total+=1;
							for arquivo in $(cat $word);
							do
								rarquivo=$(curl -s -e robots.txt -o /dev/null -w "%{http_code}" $site/$palavra/$arquivo)
								if [ $rarquivo == "200" ]
								then
									echo "	-> Arquivo encontrado: $site/$palavra/$arquivo"
									let totalarq+=1;
								fi
							done
						fi
					done
						echo "Total de sites encontrados: $total"
						echo "Total de arquivos encontrados: $totalarq"
				else
					echo "Site não existe!!!"
				fi
		else
			echo " Não foi selecionado a opção 1 - Sim nem a 2 - Não \n dessa forma o script será cancelado."
		fi
	fi
fi