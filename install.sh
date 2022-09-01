#!/usr/bin/env bash

echo "====== INICIANDO SCRIPT ======"
echo

echo "------- Limpando links -------"
echo

for i in $(ls -d */)
do
    echo -e "Link ${i} removido"; sleep 1; stow -D $i
done

echo
echo "------- Criando  links -------"
echo
for i in $(ls -d */)
do
    echo -e "Criando link para a pasta ${i}"; sleep 1; stow $i 
done

echo
echo "========= FINALIZADO ========="
