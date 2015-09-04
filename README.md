# overlappingReads
*Currently under development.*
Version 0.1  
2015-08-05

### Disclaimer
This pipeline is made available **with no warranty of usefulness of any kind**.  
Purpose: remove adapters then merge overlapping reads (i.e. paired-end where insert size is less than the length of R1 + R2)

When paired end data is overlapping, it can improve assemblies to collapse the two reads into a single read
prior to use in an assembler.

Outcome: a combination of single-end (i.e. less than the length of R1+R2) reads and paired-end reads (i.e. when insert size is greater than R1+R2).

Requires the following:  
`cutadapt`         http://cutadapt.readthedocs.org/en/stable/  
`FLASh`            http://ccb.jhu.edu/software/FLASH/ 

### General comments
Put raw *fastq.gz single-end data in 02_raw_data  
Please note that reads must end in *R1.fastq.gz or *R1.fastq (or the R2 equivalent)  
Run all jobs from the main directory  
Job files are specific to Katak at IBIS, but with some minor editing can be adapted for other servers  

##1. Remove Adapters
At this stage, we do not trim based on quality, as base call quality is used by the merging program to decide when to merge the two reads. Using paired end mode (via the -p flag) will ensure that the output files are equal (i.e. if a read is removed from one library it will also be removed from the paired library).



##2. Merge Reads
Edit 01_scripts/02_flash_merge.sh by providing the full path to the FLASH program.
Output will be in `04_binned_pairs`, and will be either the 'extendedFrags.fastq.gz' or the forward/reverse reads. 
**note, currently this requires a temp folder within 04_binned_pairs entitled 03_adapter_removed/ but this will be fixed soon





