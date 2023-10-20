#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process hello {
      output:
      path 'hi.txt'
      script:
      """
      echo 'hello world' > hi.txt
      """
}


process CONVERT {
    input:
    path y

    output:
    path 'output.txt'
    
    script:
    """
    cat $y | tr '[a-z]' '[A-Z]' > output.txt
    """
}

workflow {
file = hello() 
CONVERT(file)
view
}