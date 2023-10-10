# FastQC-nf bioinformatics workflow

## Description
FastQC-nf is a pipeline for quality control in both illumina short reads and Pacbio long reads. 
It's written in nextflow workflow. This project includes several stages: 
1. First script "Hello World"
2. Perform fastQC in a single fastq file with --fq & --output parameterss

## User guide

## Component tools

## Additional notes
First, the script was written 
'''
#!/usr/bin/env nextflow 

nextflow.enable.dsl=2 

process fastqc { 

 

    cpus 2 

    memory '12 GB' 

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
'''
## Help / FAQ / Troubleshooting

## License(s)

## Acknowledgements/citations/credits
Sydney Informatics Hub 'SIH'