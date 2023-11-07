#!/usr/bin/env nextflow

// To use DSL-2 will need to include this
nextflow.enable.dsl=2

// =================================================================
// main.nf is the pipeline script for a nextflow pipeline
// Should contain the following sections:
	// Process definitions
    // Channel definitions
    // Workflow structure
	// Workflow summary logs 

// Examples are included for each section. Remove them and replace
// with project-specific code. For more information see:
// https://www.nextflow.io/docs/latest/index.html.
//
// ===================================================================

// Import processes or subworkflows to be run in the workflow
// Each of these is a separate .nf script saved in modules/ directory
// See https://training.nextflow.io/basic_training/modules/#importing-modules 
/*
include { processOne } from './modules/process1'
include { processTwo } from './modules/process2' 
*/

// Print a header for your pipeline 
log.info """\

=======================================================================================
F A S T Q C - N F  
=======================================================================================

Created by Ching-Yu Lu
Find documentation @ https://github.com/Sydney-Informatics-Hub/fastqc-nf
Cite this pipeline @ INSERT DOI

=======================================================================================
Workflow run parameters 
=======================================================================================
input       : ${params.fqs}
outDir      : ${params.output}
workDir     : ${workflow.workDir}
=======================================================================================

"""

/// Help function 
// This is an example of how to set out the help function that 
// will be run if run command is incorrect or missing. 

def helpMessage() {
    log.info"""
  Usage:  nextflow run main.nf --fq-dir <fq directory> --output <directory_name> 

  Required Arguments:

  --fq_dir    Path to fq directory to be processed. 

  Optional Arguments:

  --output	Specify path to output directory. 
	
"""
}

// Define workflow structure. Include some input/runtime tests here.
// See https://www.nextflow.io/docs/latest/dsl2.html?highlight=workflow#workflow
workflow {

// Show help message if --help is run or (||) a required parameter (input) is not provided

if ( params.help || params.fqs == false ){   
// Invoke the help function above and exit
	helpMessage()
	exit 1

// If none of the above are a problem, then run the workflow
} else {
	
// Define channels 
// See https://www.nextflow.io/docs/latest/channel.html#channels
// See https://training.nextflow.io/basic_training/channels/ 
fq_ch = Channel.fromPath(params.fqs)

//dir_ch = Channel.fromPath("/scratch/nextflow/*", type: 'dir', glob: true, )
//num_ch = Channel.fromlist(['NA', 'm'])
//                .fromPath("/scratch/nextflow/*/$it*.fq.gz")
//file_ch = Channel.fromPath("/scratch/nextflow/**/*.fq.gz")
// pair_ch = Channel.fromPath("/scratch/nextflow/**/NA*_R{1,2}_10k.fq.gz", glob: true, checkIfExists: true, type: 'file')
//html_ch = Channel.watchPath()


// Execute fastqc
fastqc(fq_ch)
}}

// Print workflow execution summary 
workflow.onComplete {
summary = """
=======================================================================================
Workflow execution summary
=======================================================================================

Duration    : ${workflow.duration}
Success     : ${workflow.success}
workDir     : ${workflow.workDir}
Exit status : ${workflow.exitStatus}
outDir      : ${params.output}

=======================================================================================
  """
println summary
}
// ====================================================================================

process fastqc {
    // Specify resouce allocation for this process
    cpus 2
    memory '12 GB'
    container 'quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0'
    // you have to set up publishDir. otherwise, nextflow only show the results in the work directory
    publishDir "${params.output}", mode: 'symlink'

    input: 
    path fq

    output:
    path "*_fastqc.{zip,html}"

    script:
    """
    #!/usr/bin/env bash
    fastqc ${fq}
    """
  // If you put -o for fastqc, it will end up error and with conflict against publishDir
}