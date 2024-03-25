// Run fastqc

process fastqc {
    tag "COLLECTING QC METRICS: ${sampleID}" 
    debug = false 
    publishDir "${params.output}/${sampleID}", mode: 'copy'

    input: 
    tuple val(sampleID), path(read1), path(read2)

    output:
    path("*fastqc.html")
    path("*fastqc.zip")

    script:
    """
    fastqc ${read1} ${read2}
    """
}