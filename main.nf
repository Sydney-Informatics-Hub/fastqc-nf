#!/usr/bin/env nextflow
nextflow.enable.dsl=2
params.fq = "*.fq.gz"

process fastqc {

    cpus 2
    memory '12 GB'
    container "/home/ubuntu/singularity-hpc"

    input:
    output:
    path "results/*_fastqc.{zip,html}"

    script:
    """
    #!/usr/bin/bash
    fastqc -o results/ ${params.fq}
    """
}

workflow {
    fastqc()
}

// nextflow run main.nf --fq NA12877_R1_10k.fq.gz --output results