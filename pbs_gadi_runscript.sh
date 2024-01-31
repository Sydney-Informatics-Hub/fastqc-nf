#!/bin/bash

#PBS -P er01
#PBS -N fastqc-nf
#PBS -l walltime=01:00:00
#PBS -l ncpus=1
#PBS -l mem=40GB
#PBS -W umask=022
#PBS -q copyq
#PBS -e EM_fastqc-nf.e
#PBS -o EM_fastqc-nf.o
#PBS -l wd
#PBS -l storage=scratch/er01+gdata/er01

#Load singularity and nextflow modules
# See: https://opus.nci.org.au/display/DAE/Nextflow
# See: https://opus.nci.org.au/display/Help/Singularity
module load java
module load nextflow
module load singularity

# Fill in these variables for your run
input= #full path to your input.tsv file
output= #full path for results directory

# set singularity cache dir
export NXF_SINGULARITY_CACHEDIR= #the directory for singularity container

# Run the pipeline (remove annotsv if not needed)
nextflow run main.nf --input ${input} --output ${output}
