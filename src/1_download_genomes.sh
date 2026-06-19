#!/bin/bash

mkdir -p genomes
cd genomes

echo "Obtendo lista dos 50 primeiros genomas completos de E. coli..."

datasets summary genome taxon "Escherichia coli" \
  --assembly-level complete \
  --as-json-lines 2>/dev/null | \
  head -50 | \
  python3 -c "
import sys, json
for line in sys.stdin:
    try:
        data = json.loads(line)
        acc = data.get('accession')
        if acc:
            print(acc)
    except:
        pass
" > accessions_top50.txt

COUNT=$(wc -l < accessions_top50.txt)
echo "Encontrados $COUNT accessions"

echo "Baixando genomas..."
datasets download genome accession \
  --inputfile accessions_top50.txt \
  --include genome \
  --filename ecoli_top50.zip

echo "Descompactando..."
unzip -q ecoli_top50.zip -d ecoli_top50

echo "Pronto! Genomas em: genomes/ecoli_top50/ncbi_dataset/data/"
ls ecoli_top50/ncbi_dataset/data/ | wc -l
echo "genomas baixados"