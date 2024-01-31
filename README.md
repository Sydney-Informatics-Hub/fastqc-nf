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

### Prepare input.tsv file 

To run this pipeline you will need the following inputs:

* fastq files
* Input sample sheet

You will need to create a sample sheet with information about the samples you are processing, before running the pipeline. 
This file must be **tab-separated** and contain a header and one row per sample. Columns should correspond to sampleID and read location:

|sampleID|read                       |
|--------|---------------------------|
|SAMPLE1 |/scratch/fq/sample1.1.fq.gz|
|SAMPLE2 |/scratch/fq/sample2.1.fq.gz|

When you run the pipeline, you will use the mandatory `--input` parameter to specify the location and name of the input file:

```
--input /path/to/input.tsv
```

#### Download workflow code 

Download the code contained in this repository with:

```
 git clone https://github.com/Sydney-Informatics-Hub/fastqc-nf.git
```

#### Setup output directory

Into fastqc-nf directory and create output directories. 

```
mkdir results
```


### Execute the workflow 

You will need to execute this workflow from inside the `fastqc-nf` directory. Execute the workflow using the command below: 

```
nextflow run main.nf --input <provide full path to the input.tsv file>
```

For example: 

```
nextflow run main.nf --input ../bio-data/fastq/input.tsv 
```

Before running, adjust the following flags:
* `--input` specify the full path to the input.tsv
* `--output` name a directory to output the fastqc files to

### Attention

In some dataset, when you perform fastqc, it may come up 
```
java.lang.OutOfMemoryError: Java heap space
```
You can add a -t 2 flag in fastqc. [issue86](https://github.com/s-andrews/FastQC/issues/86)
```
fastqc -t 2 ${read}
```

## Acknowledgements

The authors acknowledge the technical assistance provided by the Sydney Informatics Hub (SIH), a Core Research Facility of the University of Sydney and the Australian BioCommons.
