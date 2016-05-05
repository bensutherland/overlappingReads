# overlappingReads
Version 1.0 
2015-09-12  

### Disclaimer
This pipeline is made available **with no warranty of usefulness of any kind**.  
Purpose: remove adapters then merge overlapping reads i.e. paired-end reads where **sequenced insert size < length(R1) + length(R2)**  

When paired end data is overlapping, it can improve assemblies to merge the two reads into a single read
prior to genome assembly.

This pipleine outputs merged single reads and unmerged paired reads.  

Requires the following:  
`cutadapt`         http://cutadapt.readthedocs.org/en/stable/  
`FLASh`            http://ccb.jhu.edu/software/FLASH/ 

### General comments
Put raw *fastq.gz paired-end data in 02_raw_data  
*Please note that reads must end in *R1.fastq.gz or *R1.fastq (or the R2 equivalent)*   
Put fasta file containing the illumina adapters present in the data  

Run all jobs from the main directory  
Job submission files are specific to Katak at IBIS, but with some minor editing can be adapted for other servers  

##a) Remove Adapters
Trim adapters from raw .fastq.gz files using `cutadapt`
At this stage, we do not trim based on quality, as base call quality is used by the merging program to decide when to merge the two reads. Using paired end mode (via the -p flag) will ensure that the output files are equal (i.e. if a read is removed from one library it will also be removed from the paired library).

Edit 01_scripts/01_cutadapt.sh by providing the path to `cutadapt` and to a fasta file containing the forward and reverse adapters (in script as `ILLUMINA_ADAPTERS`).
Run locally:
```
01_scripts/01_cutadapt.sh
```

Run on Katak: 
```
qsub 01_scripts/jobs/01_cutadapt_job.sh
```

##b) Merge Reads
When a single read within R1 and R2 overlap, they are merged into a single read. 
Output will be in `04_binned_pairs`, and will be either the 'extendedFrags.fastq.gz' or 'notCombined_[12].fastq.gz'.  
Output quality control (i.e. histogram files) are moved to 04_binned_pairs/output_histograms/ 

Edit 01_scripts/02_flash_merge.sh by providing the full path to `FLASh` 
Run locally:
```
01_scripts/02_flash_merge.sh
```

Run on Katak: 
```
qsub 01_scripts/jobs/02_flash_merge_job.sh
```

##c) Assess output of merging
Output files are in 04_binned_pairs/output_histograms/  
These contain graphical representation of the proportion of reads within each bp length   
View using `less` to get an understanding of your size distribution
