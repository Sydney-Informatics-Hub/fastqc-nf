#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process helloworld {
  input: 
    val x
  output:
    stdout
  script:
    """
    echo '$x world!'
    """
}
workflow {
  Channel.of('Ciao', 'Hello', 'Hola') | helloworld | view
}