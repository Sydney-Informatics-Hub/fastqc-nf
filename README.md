# FastQC-nf bioinformatics workflow

 - [Description](#description)
 - [User Guide](#user-guide)
 - [Additional notes](#additional-notes)
 - [Acknowledgements](#acknowledgements)

## Description
FastQC-nf is a pipeline designed to build a Nextflow workflow based on FastQC, a quality control software developed by [Babraham Bioinformatics](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/). FastQC is utilized for assessing the quality of raw sequence data obtained from high-throughput sequencing pipelines. It is versatile, capable of analyzing both Illumina short reads and PacBio long reads. This project aims to help users become proficient in creating Nextflow workflows and applying them to their own projects.

Nextflow is a powerful workflow orchestration engine and domain-specific language (DSL) that simplifies the creation of data-intensive computational workflows. In the field of bioinformatics, the output data can be extensive and often involves multiple programming languages, especially when working with next-generation sequencing pipelines. Nextflow provides consistency and reproducibility by leveraging containerization on various platforms.

Key features of Nextflow include:

1. Workflow portability and reproducibility
2. Scalability for parallelization and deployment
3. Integration with existing tools, systems, and industry standards

This project comprises several stages:

1. Creating the initial "Hello World" script.
2. Running FastQC on a single FASTQ file with the use of the --fq and --output parameters.
3. Executing FastQC on multiple FASTQ files by specifying the --fq-dir and --output parameters.

## Diagram 
![diagram](workflow1.bmp)

## User guide

### Data
The test data is download from [bio-test-datasets](https://github.com/Sydney-Informatics-Hub/bio-test-datasets/tree/main#bio-test-datasets), which contains Paired-end Platinum Genomes fastq files for NA12877 subset to 10k reads. 

### Set up

 ```
 git clone https://github.com/Sydney-Informatics-Hub/fastqc-nf.git
```

### Execution:

### For task_1_hello_world

#### main-1-1.nf

```
 nextflow run main-1-1.nf
 ```
#### main-1-2.nf

```
 nextflow run -e.mode=ciao main-1-2.nf
```
#### main-1-3.nf

```
 nextflow run main-1-3.nf
```

### For task_2_fastq_1

main-2-1.nf

```
 nextflow run main-2-1.nf --fq NA12877_R1_10k.fq.gz --output results
```

## Acknowledgements
The authors acknowledge the technical assistance provided by the Sydney Informatics Hub (SIH), a Core Research Facility of the University of Sydney and the Australian BioCommons.