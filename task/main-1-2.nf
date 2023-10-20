#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process helloworld2 {
  output:
    stdout
  script:
    if (mode == "hola")
    """
    echo 'Hola world!'
    """
    else if (mode == "hello")
    """
    echo 'Hello world!!'
    """
    else if (mode == "ciao")
    """
    echo 'Ciao world!!!'
    """
}
workflow {
  helloworld2 | view
}

// commands "nextflow run -e.mode=ciao main-1.nf"