#!/bin/bash

# Análise pangenômica com Panaroo usando anotações do Prokka e do Bakta
# Requer: panaroo instalado
# Ativar ambiente: conda activate panaroo_env

set -e

mkdir -p pangenome_panaroo/prokka
mkdir -p pangenome_panaroo/bakta

# --- Panaroo com anotações Prokka ---
echo "Rodando Panaroo com anotacoes Prokka..."

panaroo \
    -i prokka/gff_ecoli_prokka/*.gff \
    -o pangenome_panaroo/prokka \
    --clean-mode strict \
    -t 4 \
    --verbose

echo "Panaroo (Prokka) concluido!"
echo "Resultados em: pangenome_panaroo/prokka/"

# --- Panaroo com anotações Bakta ---
echo ""
echo "Rodando Panaroo com anotacoes Bakta..."

panaroo \
    -i bakta/gff_ecoli_bakta/*.gff3 \
    -o pangenome_panaroo/bakta \
    --clean-mode strict \
    -t 4 \
    --verbose

echo "Panaroo (Bakta) concluido!"
echo "Resultados em: pangenome_panaroo/bakta/"

# --- Resumo comparativo Panaroo ---
echo ""
echo "=== RESUMO PANAROO ==="
for tool in prokka bakta; do
    summary="pangenome_panaroo/${tool}/summary_statistics.txt"
    if [ -f "$summary" ]; then
        echo ""
        echo "--- $tool ---"
        cat "$summary"
    fi
done

echo ""
echo "Analise pangenomica com Panaroo finalizada!"
