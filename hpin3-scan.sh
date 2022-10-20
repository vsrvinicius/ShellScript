#!/bin/bash

echo "Digite a rede:"
read rede
# portas=(587,110,465,143,993)

for ip in {1..254};
do
	hping3 $rede.$ip -S --scan 110
	hping3 $rede.$ip -S --scan 143
	hping3 $rede.$ip -S --scan 465
	hping3 $rede.$ip -S --scan 587
	hping3 $rede.$ip -S --scan 993
done
