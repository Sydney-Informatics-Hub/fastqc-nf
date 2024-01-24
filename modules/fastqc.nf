// Run fastqc

process fastqc {
    
    debug = true //turn to false to stop printing command stdout to screen
    // you have to set up publishDir. otherwise, nextflow only show the results in the work directory
    publishDir "${params.output}/${sampleID}", mode: 'copy'

    input: 
    tuple val(sampleID), path(read1), path(read2)

    output:
    path("${sampleID}*fastqc.html")
    path("${sampleID}*fastqc.zip")

    script:
    """
    mkdir ${sampleID}
    fastqc ${read1} ${read2}

    """
}