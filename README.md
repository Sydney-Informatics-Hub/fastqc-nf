# FastQC-nf 

 - [Description](#description)
 - [User Guide](#user-guide)
 - [Workflow metadata](#Workflow-summaries)
 - [Acknowledgements](#acknowledgements)

## Description

FastQC-nf is a Nextflow workflow for evaluating the quality of high-throughput sequencing reads. It employs [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) to assess the quality of individual fastq files. FastQC metrics are then aggregated into a single HTML report using [MultiQC](https://multiqc.info/). This pipeline accepts both Illumina short read datasets for WGS and RNAseq data. 

When applying this pipeline to RNAseq data, please consider that the following metrics will FAIL due to the following assumptions of FastQC: 

* Per-base sequence content
* Per-sequence GC content
* Sequence duplication levels
* Overrepresented srequences 

This is because we always expect to see a high level of duplication in RNAseq data. This is because there is much less RNA in biological tissues, than DNA, and so the same RNA molecules are sequenced many times. By chance, RNA will be fragmented at the same spot and sequenced many times. For DNA, the purpose of FastQC metrics is to check for technical biases in the library preparation and sequencing process, when the sequencer reads the same strands multiple times. 

## User guide

### 0. Install Nextflow and Singularity

To run this pipeline you must have Nextflow (>=20.07.1) and Singularity installed on your machine. All tools are run using containers. 

* [Nextflow installation instructions](https://www.nextflow.io/docs/latest/getstarted.html)
* [Singularity installation instructions](https://docs.sylabs.io/guides/3.0/user-guide/installation.html)

If you are working on **NCI Gadi**, you can load these preinstalled modules: 

```bash
module load nextflow 
module load singularity
```

### 1. Clone this repository

Download the code contained in this repository with the following command:

```bash
git clone https://github.com/Sydney-Informatics-Hub/fastqc-nf.git
```

This will create a directory with the following structure: 
```bash
fastqc-nf/
├── config/
├── LICENSE
├── main.nf
├── modules/
├── nextflow.config
└── README.md
```

The important features are:

* `main.nf` contains the main nextflow script that calls all the processes in the workflow.
* `nextflow.config` contains default parameters to use in the pipeline.
* `modules/` contains individual process files for each step in the workflow.
* `config/` contains infrastructure-specific config files (currently only contains gadi.config)

### 2. Set your cache directories 

This workflow pulls FastQC and MultiQC containers to be executed by Singularity. We recommend that you specify a cache directory on your system using `NXF_SINGULARITY_CACHEDIR` in your `~/.bash_profile` or `~/.bashrc` file. This will prevent the containers from being downloaded every time you run the pipeline. If you are running this pipeline on NCI Gadi, provide a path to the `$NXF_SINGULARITY_CACHEDIR` in the `run_gadi.pbs` script before you execute it. 

You can also do this just for your current shell session, e.g.: 

```bash
export NXF_SINGULARITY_CACHEDIR=/scratch/$PROJECT/$USER/.singularity
```

### 3. Make the input samplesheet

To run this pipeline you will need the following inputs:

* Fastq files 
* Input sample sheet

You will need to create a sample sheet with information about the samples you are processing, before running the pipeline. 
This file must be **comma-separated** (.csv) and contain a header and one row per fastq pair. Columns should correspond to sample, path to fq1, path to fq2:

```csv
sample,fq1,fq2
SAMPLE1,/scratch/fq/sample1.1.fq.gz,/scratch/fq/sample1.2.fq.gz
SAMPLE2,/scratch/fq/sample2.1.fq.gz,/scratch/fq/sample2.2.fq.gz
```

For samples with multiple fq pairs, you can add additional rows to the samplesheet, specifying the same sample name in the `sample` column. All FastQC reports for the same sample will be aggregated in the same directory. You will be able to view the aggregated reports for each fastq read file in the `multiqc_report.html` file.

When you run the pipeline, you will use the mandatory `--input` parameter to specify the location and name of the input file:

```
--input /path/to/input.tsv
```

### 4. Execute the workflow 

Execute the workflow using the command below, from inside the `fastqc-nf` directory: 

```
nextflow run main.nf --input </full/path/to/input.tsv>
```

For example: 
```
nextflow run main.nf --input ../bio-data/fastq/input.tsv 
```

Before running, adjust the following flags:
* `--input` specify the full path to the input.tsv
* `--output` name a directory to output the QC reports to

#### Running on NCI Gadi 

This pipeline has been configured for execution on NCI Gadi's job scheduler. To run on Gadi, you will need to add the following flags:

* `--gadi_account <project code>`
* `-profile gadi` 

For example: 

```
nextflow run main.nf --input ../bio-data/fastq/input.tsv -profile gadi --gadi_account aa11
```

## Workflow summaries
### Metadata

|metadata field     | fastqc-nf / v1.0.0                |
|-------------------|:--------------------------------- |
|Version            | 1.0.0                             |
|Maturity           | First release                     |
|Creators           | Ching-Yu Lu, Georgie Samaha, Cali Willet |
|Source             | NA                                |
|License            | GNU General Public License v3.0   |
|Workflow manager   | Nextflow                          |
|Container          | See component tools               |
|Install method     | NA                                |
|GitHub             | https://github.com/Sydney-Informatics-Hub/fastqc-nf |
|bio.tools          | NA                                |
|BioContainers      | NA                                |
|bioconda           | NA                                |

### Component tools

To run this pipeline you must have Nextflow and Singularity installed on your machine. All other tools are run using containers.

|Tool         | Version  |
|-------------|:---------|
|Nextflow     |>=20.07.1 |
|Singularity  |          |
|FastQC       |0.12.1    |
|MultiQC      |1.17      |

## Acknowledgements

This pipeline was built using the [Nextflow DSL2 template](https://github.com/Sydney-Informatics-Hub/Nextflow_DSL2_template). Documentation was created following the [Australian BioCommons documentation guidelines](https://github.com/AustralianBioCommons/doc_guidelines). Acknowledgements (and co-authorship, where appropriate) are an important way for us to demonstrate the value we bring to your research. Your research outcomes are vital for ongoing funding of the Sydney Informatics Hub and national compute facilities. We suggest including the following acknowledgement in any publications that follow from this work:

*The authors acknowledge the technical assistance provided by the Sydney Informatics Hub, a Core Research Facility of the University of Sydney and the Australian BioCommons which is enabled by NCRIS via Bioplatforms Australia.*

### Contributors

* Ching-Yu Lu (Sydney Informatics Hub, University of Sydney)
* Georgie Samaha (Sydney Informatics Hub, University of Sydney)
* Cali Willet (Sydney Informatics Hub, University of Sydney)


