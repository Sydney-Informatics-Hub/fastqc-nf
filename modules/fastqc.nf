// Run fastqc

process fastqc {
    
    debug = true //turn to false to stop printing command stdout to screen
    // you have to set up publishDir. otherwise, nextflow only show the results in the work directory
    publishDir "${params.output}/${sample_id}", mode: 'symlink'

    input: 
    tuple val(sample_id), path(fqs)

    output:
    path "${sample_id}_R1_10k_fastqc.{zip,html}"
    path "${sample_id}_R2_10k_fastqc.{zip,html}"

    script:
    """
    #!/usr/bin/env bash
    cd ${params.output}
    mkdir ${sample_id}
    fastqc ${fqs}
    """
}