#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process foo {

    output:

      path 'foo.txt'

    script:

      """
      #!/usr/bin/bash

      echo "Hello World" > foo.txt

      """

}

 

 process bar {

    input:

      path x

    output:

      path 'bar.txt'

    script:

      """

      cat $x > bar.txt

      """

}

 

workflow {
foo()
    //data = foo() 
    //bar(data)

}