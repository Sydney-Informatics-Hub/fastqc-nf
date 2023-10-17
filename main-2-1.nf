#!/usr/bin/env nextflow
nextflow.enable.dsl=2
params.fq = "*.fq.gz"

process fastqc {

    cpus 2
    memory '12 GB'
    container 'biocontainers/fastqc'

    input:
    output:
    path "results/*_fastqc.{zip,html}"

    script:
    """
    #!/usr/bin/env bash
    fastqc -o results/ ${params.fq}
    """
}

workflow {
    fastqc()
}