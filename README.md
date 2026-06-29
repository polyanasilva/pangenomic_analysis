# Avaliação Comparativa de Pipeline de Anotação Genômica: Impacto na Análise Pangenômica

Repositório do estágio curricular com o objetivo de comparar ferramentas de anotação genômica (Prokka e Bakta) e avaliar o impacto dessas anotações em análises pangenômicas (Roary e Panaroo), usando 50 genomas completos de *Escherichia coli* como conjunto de dados.

---

## Estrutura do projeto

```
novo_projeto/
├── src/                          # Scripts do pipeline (ordem de execução)
│   ├── 1_download_genomes.sh     # Baixa os 50 genomas do NCBI
│   ├── 2_organize_genomes.sh     # Organiza os .fna em genomes_ecoli/
│   ├── 3_prokka_annotation.sh    # Anota todos os genomas com Prokka
│   ├── 4_organize_annotations.sh # Centraliza os .gff do Prokka
│   ├── 5_bakta_annotation.sh     # Anota todos os genomas com Bakta
│   ├── 6_organize_bakta.sh       # Centraliza os .gff do Bakta
│   ├── 7_comparative_analysis.sh # Comparação Prokka vs Bakta (CDS, tRNA, rRNA, hipotéticas)
│   ├── 8_roary_pangenome.sh      # Pangenoma com Roary (Prokka e Bakta)
│   └── 9_panaroo_pangenome.sh    # Pangenoma com Panaroo (Prokka e Bakta)
├── genomes_ecoli/                # Genomas .fna brutos (50 genomas)
├── annotation_prokka/            # Saída completa do Prokka por genoma
├── annotation_bakta/             # Saída completa do Bakta por genoma
├── gff_ecoli_prokka/             # .gff do Prokka centralizados
├── gff_ecoli_bakta/              # .gff do Bakta centralizados
├── comparative_analysis/         # Tabela comparativa Prokka vs Bakta
├── pangenome_roary/
│   ├── prokka/                   # Resultado Roary com anotações Prokka
│   └── bakta/                    # Resultado Roary com anotações Bakta
└── pangenome_panaroo/
    ├── prokka/                   # Resultado Panaroo com anotações Prokka
    └── bakta/                    # Resultado Panaroo com anotações Bakta
```

---

## Dependências

| Ferramenta | Uso | Instalação sugerida |
|---|---|---|
| [NCBI Datasets](https://www.ncbi.nlm.nih.gov/datasets/docs/v2/download-and-install/) | Download de genomas | `conda install -c conda-forge ncbi-datasets-cli` |
| [Prokka](https://github.com/tseemann/prokka) | Anotação genômica | `conda install -c bioconda prokka` |
| [Bakta](https://github.com/oschwengers/bakta) | Anotação genômica | `conda install -c bioconda bakta` |
| [Roary](https://github.com/sanger-pathogens/Roary) | Análise pangenômica | `conda install -c bioconda roary` |
| [Panaroo](https://github.com/gtonkinhill/panaroo) | Análise pangenômica | `conda install -c bioconda panaroo` |

---

## Como reproduzir

Execute os scripts na ordem numérica a partir da raiz do repositório:

```bash
# 1. Baixar genomas
bash src/1_download_genomes.sh

# 2. Organizar genomas
bash src/2_organize_genomes.sh

# 3. Anotar com Prokka (requer: conda activate prokka_env)
bash src/3_prokka_annotation.sh

# 4. Organizar .gff do Prokka
bash src/4_organize_annotations.sh

# 5. Anotar com Bakta (requer: conda activate bakta_env + banco de dados)
bash src/5_bakta_annotation.sh

# 6. Organizar .gff do Bakta
bash src/6_organize_bakta.sh

# 7. Análise comparativa Prokka vs Bakta
bash src/7_comparative_analysis.sh

# 8. Pangenoma com Roary (requer: conda activate roary_env)
bash src/8_roary_pangenome.sh

# 9. Pangenoma com Panaroo (requer: conda activate panaroo_env)
bash src/9_panaroo_pangenome.sh
```

> **Nota sobre o Bakta:** é necessário baixar o banco de dados antes de rodar o script 5.
> ```bash
> bakta_db download --output ~/bakta_db
> ```
> O caminho do banco pode ser ajustado na variável `DB_PATH` dentro de `5_bakta_annotation.sh`.

---

## Saídas principais

| Arquivo/Pasta | Descrição |
|---|---|
| `comparative_analysis/annotation_comparison.tsv` | Tabela com CDS, tRNA, rRNA e proteínas hipotéticas por genoma e ferramenta |
| `pangenome_roary/prokka/summary_statistics.txt` | Resumo do pangenoma (core, shell, cloud) — Roary + Prokka |
| `pangenome_roary/bakta/summary_statistics.txt` | Resumo do pangenoma — Roary + Bakta |
| `pangenome_panaroo/prokka/summary_statistics.txt` | Resumo do pangenoma — Panaroo + Prokka |
| `pangenome_panaroo/bakta/summary_statistics.txt` | Resumo do pangenoma — Panaroo + Bakta |

---

## Fluxo do pipeline

```
50 genomas .fna (NCBI)
        │
        ├──► Prokka ──► gff_ecoli_prokka/ ──┐
        │                                    ├──► Análise comparativa
        └──► Bakta  ──► gff_ecoli_bakta/  ──┘
                                             │
                              ┌──────────────┴──────────────┐
                              ▼                             ▼
                      Roary (prokka + bakta)    Panaroo (prokka + bakta)
```
