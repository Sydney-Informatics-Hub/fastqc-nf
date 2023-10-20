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
input       : ${params.fq}
outDir      : ${params.output}
workDir     : ${workflow.workDir}
=======================================================================================

"""

/// Help function 
// This is an example of how to set out the help function that 
// will be run if run command is incorrect or missing. 

def helpMessage() {
    log.info"""
  Usage:  nextflow run main.nf --fq <fq file> --output <directory_name> 

  Required Arguments:

  --fq    Path to fq file to be processed. 

  Optional Arguments:

  --output	Specify path to output directory. 
	
"""
}

// Define workflow structure. Include some input/runtime tests here.
// See https://www.nextflow.io/docs/latest/dsl2.html?highlight=workflow#workflow
workflow {

// Show help message if --help is run or (||) a required parameter (input) is not provided

if ( params.help || params.fq == false ){   
// Invoke the help function above and exit
	helpMessage()
	exit 1
	// consider adding some extra contigencies here.
	// could validate path of all input files in list?
	// could validate indexes for reference exist?

// If none of the above are a problem, then run the workflow
} else {
	
// Define channels 
// See https://www.nextflow.io/docs/latest/channel.html#channels
// See https://training.nextflow.io/basic_training/channels/ 
params.fq = "*.fq.gz"

fastqc()
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
outDir      : ${params.outDir}

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

    input:
    output: 
    path "results/*_fastqc.{zip,html}"

    script:
    """
    fastqc -o results/ ${params.fq}
    """
}

/*
search for the fastqc biocontainer in https://quay.io/ and provide to container scope i.e:
container "quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0" 
Nextflow will pull a container for you automatically when you run a workflow
TODO later look at what to do about pulling containers when your job has no external network access
When using Singularity to manage containers with nextflow, dont need to clarify it is a docker container. For example when pulling a Docker container with Singularity normally you would use:
singularity pull docker://quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0
                                                    ~ Georgie 18102023

*/