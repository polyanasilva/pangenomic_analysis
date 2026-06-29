#!/bin/bash

# Organiza os arquivos .gff gerados pelo Bakta em uma pasta centralizada

set -e

mkdir -p bakta/gff_ecoli_bakta

echo "Movendo arquivos .gff3 para bakta/gff_ecoli_bakta/..."
find bakta/annotation_bakta/ -name "*.gff3" | while read f; do
    cp "$f" bakta/gff_ecoli_bakta/
    echo "  Copiado: $(basename $f)"
done

echo ""
echo "Pronto! $(ls bakta/gff_ecoli_bakta/*.gff3 | wc -l) arquivos .gff3 em bakta/gff_ecoli_bakta/"
