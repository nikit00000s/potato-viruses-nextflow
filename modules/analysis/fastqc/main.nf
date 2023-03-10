include { getOutputDir } from '../../helpers/main.nf'


process FASTQC {
    tag "$meta.idx $meta.region $meta.variety"
    label "process_medium"
    publishDir "$getOutputDir('fastqc_original')"

    conda (params.enable_conda ? "bioconda::fastqc=0.11.9" : null)
    
    input:
    tuple val(meta) path(reads_1) path(reads_2)

    output:
    tuple val(meta), path("*.html"), emit: html
    tuple val(meta), path("*.zip") , emit: zip
    path  "versions.yml"           , emit: versions

    script:
    def args = task.ext.args ?: ''
    
    """
    fastqc $args --threads $task.cpus ${reads_1} ${reads_2}
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        fastqc: \$( fastqc --version | sed -e "s/FastQC v//g" )
    END_VERSIONS
    """
    
}
//    fastqc $args --threads $task.cpus ${meta.lib_name}_1.fastq.gz ${meta.lib_name}_2.fastq.gz
//    [ ! -f  ${prefix}_1.fastq.gz ] && ln -s ${reads[0]} ${meta.lib_name}_1.fastq.gz
//    [ ! -f  ${prefix}_2.fastq.gz ] && ln -s ${reads[1]} ${meta.lib_name}_2.fastq.gz