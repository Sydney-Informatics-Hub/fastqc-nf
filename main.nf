#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process fastqc {

    cpus 2
    memory '12 MB'
    container "/home/ubuntu/singularity-hpc"

    input:
    path "NA12877_R1_10k.fq.gz"

    output:
    path "results/*_fastqc.{zip,html}"

    script:
    """
    #!/usr/bin/bash
    fastqc -o results/ $input
    """
}

workflow {
    fastqc() | view
}