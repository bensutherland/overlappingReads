# overlappingReads
*Currently under development.*
Version 0.1  
2015-08-05

### Disclaimer
This pipeline is made available **with no waranty of usefulness of any kind**.  
Purpose: remove adapters then merge overlapping reads (i.e. paired-end where insert size is less than the length of R1 + R2)

When paired end data is overlapping, it can improve assemblies to collapse the two reads into a single read
prior to use in an assembler.

Outcome: a combination of single-end (i.e. less than the length of R1+R2) reads and paired-end reads (i.e. when insert size is greater than R1+R2).

Requires the following:  
`cutadapt`         http://cutadapt.readthedocs.org/en/stable/  
`pear`                http://sco.h-its.org/exelixis/web/software/pear/   

### General comments
Put raw *fastq.gz single-end data in 02_raw_data  
Please note that reads must end in *R1.fastq.gz or *R1.fastq (or the R2 equivalent)  
Run all jobs from the main directory  
Job files are specific to Katak at IBIS, but with some minor editing can be adapted for other servers  

##1. Remove Adapters
At this stage, we will not trim based on quality, as even the low quality bases are going to be used (intelligently) by the merging program.
