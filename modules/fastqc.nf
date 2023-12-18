// Run fastqc

process fastqc {
    
    debug = true //turn to false to stop printing command stdout to screen
    // you have to set up publishDir. otherwise, nextflow only show the results in the work directory
    publishDir "${params.output}/${sampleID}", mode: 'symlink'

    input: 
    tuple val(sampleID), path(read1), path(read2)

    output:
    tuple val(sampleID), path ("${sampleID}_R1_10k_fastqc.{zip,html}"), path ("${sampleID}_R2_10k_fastqc.{zip,html}")
    
    script:
    """
    cd ${params.output}
    mkdir ${sampleID}
    fastqc /scratch/er01/cl9310/bio-test-datasets/fastq/${read1}
    fastqc /scratch/er01/cl9310/bio-test-datasets/fastq/${read2}
    """
}