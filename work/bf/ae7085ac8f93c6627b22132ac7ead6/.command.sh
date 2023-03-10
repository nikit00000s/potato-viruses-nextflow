#!/bin/bash -ue
fastqc  --threads 1 RNA_S6572Nr1_1.fastq.gz RNA_S6572Nr1_2.fastq.gz
cat <<-END_VERSIONS > versions.yml
"MAIN_PIPELINE:FASTQC":
    fastqc: $( fastqc --version | sed -e "s/FastQC v//g" )
END_VERSIONS
