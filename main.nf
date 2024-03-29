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

include { checkInputs } from './modules/check_cohort'
include { fastqc  } from './modules/fastqc'
include { multiqc } from './modules/multiqc' 

// Print a header for your pipeline 
log.info """   

=======================================================================================
F A S T Q C - N F  v.1.0.0
=======================================================================================

Created by Ching-Yu Lu, Sydney Informatics Hub, University of Sydney
Find documentation @ https://github.com/Sydney-Informatics-Hub/fastqc-nf

=======================================================================================
Workflow run parameters 
=======================================================================================
input       : ${params.input}
outDir      : ${params.output}
workDir     : ${workflow.workDir}
=======================================================================================
"""

/// Help function 
def helpMessage() {
    log.info"""
  Usage:  nextflow run main.nf --input <full path> --output <directory_name> 

  Required Arguments:

  --input   Full path and name of sample input file (csv format)

  Optional Arguments:

  --output	      Specify path to output directory. 
  --gadi_account  Specify Gadi account to use for job submission with gadi.config
	
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

// If none of the above are a problem, then run the workflow
} else {

  // Check inputs file exists
	checkInputs(Channel.fromPath(params.input, checkIfExists: true))

	// Split cohort file to collect info for each sample
	inputs = checkInputs.out
		.splitCsv(header: true)
		.map { row -> tuple(row.sample, file(row.fq1), file(row.fq2))}

  // Execute fastqc
	fastqc(inputs)

  // Generate multiqc report
	multiqc(fastqc.out[1].collect())

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