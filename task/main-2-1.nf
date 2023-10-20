#!/usr/bin/env nextflow

/// To use DSL-2 will need to include this
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
include { processOne } from './modules/process1'
include { processTwo } from './modules/process2' 

// Print a header for your pipeline 
log.info """\

=======================================================================================
Name of the pipeline - fastqc_nf 
=======================================================================================

Created by Ching-yu Lu 
Find documentation @ https://sydney-informatics-hub.github.io/Nextflow_DSL2_template_guide/
Cite this pipeline @ INSERT DOI

=======================================================================================
Workflow run parameters 
=======================================================================================
input       : ${params.input}
outDir      : ${params.outDir}
workDir     : ${workflow.workDir}
=======================================================================================

"""

/// Help function 
// This is an example of how to set out the help function that 
// will be run if run command is incorrect or missing. 

def helpMessage() {
    log.info"""
  Usage:  nextflow run main.nf --input <samples.tsv> 

  Required Arguments:

  --input	Specify full path and name of sample
		input file (tab separated).

  Optional Arguments:

  --outDir	Specify path to output directory. 
	
"""
}

// Define workflow structure. Include some input/runtime tests here.
// See https://www.nextflow.io/docs/latest/dsl2.html?highlight=workflow#workflow
workflow {

// Show help message if --help is run or (||) a required parameter (input) is not provided

if ( params.help || params.input == false ){   
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
	input = Channel.value("${params.input}")

// Run process 1 
// See https://training.nextflow.io/basic_training/processes/#inputs 
	processOne(input)
	
// Run process 2 which takes output of process 1 
	processTwo(processOne.out.File)
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

=======================================================================================
  """
println summary

// ====================================================================================

params.fq = "*.fq.gz"

process fastqc {
    // Specify resouce allocation for this process
    cpus 2
    memory '12 GB'
    // Point the location of specified container
    container 'quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0'

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

/*
search for the fastqc biocontainer in https://quay.io/ and provide to container scope i.e:
container "quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0" 
Nextflow will pull a container for you automatically when you run a workflow
TODO later look at what to do about pulling containers when your job has no external network access
When using Singularity to manage containers with nextflow, dont need to clarify it is a docker container. For example when pulling a Docker container with Singularity normally you would use:
singularity pull docker://quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0
                                                    ~ Georgie 18102023

*/