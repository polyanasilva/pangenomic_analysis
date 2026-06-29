#!/bin/bash

# Análise pangenômica com Roary usando anotações do Prokka e do Bakta
# Requer: roary instalado
# Ativar ambiente: conda activate roary_env

set -e

# Obs: o Roary cria a pasta de saída; se ela já existir, ele gera outra com sufixo.
# Por isso a pasta NAO deve ser criada previamente.

# --- Roary com anotações Prokka ---
echo "Rodando Roary com anotacoes Prokka..."

roary \
    -e \
    -n \
    -v \
    -p 4 \
    -f pangenome_roary/prokka \
    prokka/gff_ecoli_prokka/*.gff

echo "Roary (Prokka) concluido!"
echo "Resultados em: pangenome_roary/prokka/"

# --- Roary com anotações Bakta ---
echo ""
echo "Rodando Roary com anotacoes Bakta..."

roary \
    -e \
    -n \
    -v \
    -p 4 \
    -f pangenome_roary/bakta \
    bakta/gff_ecoli_bakta/*.gff3

echo "Roary (Bakta) concluido!"
echo "Resultados em: pangenome_roary/bakta/"

# --- Resumo comparativo Roary ---
echo ""
echo "=== RESUMO ROARY ==="
for tool in prokka bakta; do
    summary="pangenome_roary/${tool}/summary_statistics.txt"
    if [ -f "$summary" ]; then
        echo ""
        echo "--- $tool ---"
        cat "$summary"
    fi
done

echo ""
echo "Analise pangenomica com Roary finalizada!"
