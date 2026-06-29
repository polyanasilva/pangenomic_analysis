mkdir -p gff_ecoli_prokka

echo "Movendo arquivos .gff para gff_ecoli_prokka/..."
find annotation_prokka/ -name "*.gff" | while read f; do
    cp "$f" gff_ecoli_prokka/
    echo "  Copiado: $(basename $f)"
done

echo "Pronto! $(ls gff_ecoli_prokka/*.gff | wc -l) arquivos .gff em gff_ecoli_prokka/"