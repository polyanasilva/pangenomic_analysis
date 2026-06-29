#!/bin/bash

# Análise comparativa entre anotações Prokka e Bakta
# Gera tabela com contagens de features por genoma e resumo estatístico

set -e

mkdir -p comparative_analysis

OUTFILE="comparative_analysis/annotation_comparison.tsv"

echo -e "genome\ttool\tCDS\ttRNA\trRNA\ttotal_features\thypothetical_proteins" > "$OUTFILE"

echo "Extraindo estatísticas das anotações Prokka..."
for gff in prokka/gff_ecoli_prokka/*.gff; do
    nome=$(basename "$gff" .gff)

    cds=$(grep -v "^#" "$gff" | awk '$3 == "CDS"' | wc -l)
    trna=$(grep -v "^#" "$gff" | awk '$3 == "tRNA"' | wc -l)
    rrna=$(grep -v "^#" "$gff" | awk '$3 == "rRNA"' | wc -l)
    total=$(grep -v "^#" "$gff" | grep -v "^$" | wc -l)
    hypo=$(grep -v "^#" "$gff" | grep -i "hypothetical protein" | wc -l)

    echo -e "${nome}\tprokka\t${cds}\t${trna}\t${rrna}\t${total}\t${hypo}" >> "$OUTFILE"
done

echo "Extraindo estatísticas das anotações Bakta..."
for gff in bakta/gff_ecoli_bakta/*.gff3; do
    nome=$(basename "$gff" .gff3)

    cds=$(grep -v "^#" "$gff" | awk '$3 == "CDS"' | wc -l)
    trna=$(grep -v "^#" "$gff" | awk '$3 == "tRNA"' | wc -l)
    rrna=$(grep -v "^#" "$gff" | awk '$3 == "rRNA"' | wc -l)
    total=$(grep -v "^#" "$gff" | grep -v "^$" | wc -l)
    hypo=$(grep -v "^#" "$gff" | grep -i "hypothetical protein" | wc -l)

    echo -e "${nome}\tbakta\t${cds}\t${trna}\t${rrna}\t${total}\t${hypo}" >> "$OUTFILE"
done

echo ""
echo "Tabela comparativa salva em: $OUTFILE"

# Resumo estatístico por ferramenta via awk
echo ""
echo "=== RESUMO POR FERRAMENTA ==="
echo ""

for tool in prokka bakta; do
    echo "--- $tool ---"
    awk -v t="$tool" '
        NR > 1 && $2 == t {
            cds_sum += $3; trna_sum += $4; rrna_sum += $5; hypo_sum += $7; n++
        }
        END {
            print "Genomas: " n
            print "Media CDS: " int(cds_sum/n)
            print "Media tRNA: " int(trna_sum/n)
            print "Media rRNA: " int(rrna_sum/n)
            print "Media hipoteticas: " int(hypo_sum/n)
        }
    ' "$OUTFILE"
    echo ""
done

echo "Analise comparativa concluida!"
