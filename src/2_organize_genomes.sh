#!/bin/bash

mkdir -p genomes_ecoli

echo "Movendo arquivos .fna para genomes_ecoli/..."
find genomes/ecoli_top50/ncbi_dataset/data/ -name "*.fna" | while read f; do
    cp "$f" genomes_ecoli/
    echo "  Copiado: $(basename $f)"
done

echo "Removendo pasta genomes/..."
rm -rf genomes

echo "Pronto! $(ls genomes_ecoli/*.fna | wc -l) arquivos .fna em genomes_ecoli/"