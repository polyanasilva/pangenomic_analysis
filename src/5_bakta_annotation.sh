#!/bin/bash

# Anotação de todos os genomas de E. coli com Bakta
# Requer: bakta + AMRFinderPlus (ambiente conda bakta_intel) e banco de dados light
# O ambiente bakta_intel contem bakta, bakta_db e amrfinder.

set -e

# Garante que o bakta e o amrfinder do ambiente bakta_intel estejam no PATH.
# (o amrfinder e obrigatorio para o bakta rodar)
export PATH="/opt/miniconda3/envs/bakta_intel/bin:$PATH"

DB_PATH="$HOME/bakta_db/db-light"  # ajuste para o caminho do seu banco de dados Bakta

mkdir -p bakta/annotation_bakta

echo "Iniciando anotação com Bakta para $(ls genomes_ecoli/*.fna | wc -l) genomas..."

for genome in genomes_ecoli/*.fna; do

    nome=$(basename "$genome" .fna)

    echo "  Anotando: $nome"

    bakta \
        --db "$DB_PATH" \
        --output bakta/annotation_bakta/${nome} \
        --prefix ${nome} \
        --genus Escherichia \
        --species coli \
        --threads 4 \
        --force \
        "$genome"

    echo "  Concluido: $nome"
done

echo ""
echo "Anotacao Bakta finalizada!"
echo "Total de genomas anotados: $(ls -d bakta/annotation_bakta/*/ | wc -l)"
