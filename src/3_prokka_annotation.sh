conda activate prokka_env

# script para rodar em todos os genomas de uma vez
for genome in genomes_ecoli/*.fna; do
    
    nome=$(basename "$genome" .fna)
    
    prokka \
        --outdir annotation_prokka/${nome} \
        --prefix ${nome} \
        --genus Escherichia \
        --species coli \
        --kingdom Bacteria \
        --cpus 4 \
        --force \
        "$genome"
done