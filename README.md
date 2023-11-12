# FastQC-nf bioinformatics workflow

 - [Description](#description)
 - [User Guide](#user-guide)
 - [Additional notes](#additional-notes)
 - [Acknowledgements](#acknowledgements)

## Description

<p align="center">
:wrench: This pipeline is currently under development :wrench:
</p>

FastQC-nf is a Nextflow workflow for evaluating the quality of high-throughput sequencing reads. It employs [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) to assess the quality of individual fastq files. FastQC metrics are then aggregated into a single HTML report using [MultiQC](https://multiqc.info/). This pipeline accepts both Illumina short read and PacBio long read datasets. 

## Diagram 
![diagram](fastqcnf_wf.bmp)

For main.nf
```
nextflow run main.nf 
```

### Set up 

Under development.

#### Install Nextflow and Singularity

To run this pipeline you must have Nextflow (>=20.07.1) and Singularity installed on your machine. All tools are run using containers. 

* [Nextflow installation instructions](https://www.nextflow.io/docs/latest/getstarted.html)
* [Singularity installation instructions](https://docs.sylabs.io/guides/3.0/user-guide/installation.html)

#### Download test data 

Note: using subset fastqs from [bio-test-datasets](https://github.com/Sydney-Informatics-Hub/bio-test-datasets/tree/main#bio-test-datasets) for testing and development. Download data by running: 

```
git clone https://github.com/Sydney-Informatics-Hub/bio-test-datasets.git
```

#### Download workflow code 

Download the code contained in this repository with:

```
 git clone https://github.com/Sydney-Informatics-Hub/fastqc-nf.git
```

#### Setup output directory

Into fastqc-nf directory and create output directories. 

```
mkdir results | mkdir ./results/multiqc
```


### Execute the workflow 

You will need to execute this workflow from inside the `fastqc-nf` directory. Execute the workflow using the command below: 

```
nextflow run main.nf --fq_dir <provide path to fq directory> --output <specify output directory>
```

For example: 

```
nextflow run main.nf --fq_dir ../bio-data/fastq --output results
```

Before running, adjust the following flags:
* `--fq_dir` specify the full path to the directory containing fastq files
* `--output` name a directory to output the fastqc files to

## Acknowledgements

The authors acknowledge the technical assistance provided by the Sydney Informatics Hub (SIH), a Core Research Facility of the University of Sydney and the Australian BioCommons.
