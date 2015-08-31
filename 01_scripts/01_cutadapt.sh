#!/bin/bash
# remove adapter sequences from reads using cutadapt

# Global variables
RAW_FOLDER="02_raw_data"
REMADAPT_FOLDER="03_adapter_removed"

# User-defined
CUTADAPT="/usr/local/bin/cutadapt"
ILLUMINA_ADAPTERS="/project/lbernatchez/drobo/users/bensuth/00_resources/illumina_adapters.fasta"
#ADAPTER_FWD="AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC"
#ADAPTER_REV="AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT"

# note: from the documentation of cutadapt 'Multiple adapters', all of the sequences in $ILLUMINA_ADAPTERS will be used as 3' adapters; but ONLY THE BEST MATCHING adapter is trimmed from each read.
# note: if choose to avoid cutting chance adapter matching, add the flag -o to the script


# remove adapters with cutadapt
ls -1 $RAW_FOLDER/*.fastq.gz | 
    perl -pe 's/R[12]\.fastq\.gz//' | 
    sort -u | 
    while read i
    do
      echo $i
      $CUTADAPT \
        -a file:$ILLUMINA_ADAPTERS \
        -A file:$ILLUMINA_ADAPTERS \
        -o "$i"R1.remadapt.fastq.gz -p "$i"R2.remadapt.fastq.gz \
	"$i"R1.fastq.gz "$i"R2.fastq.gz \
        -e 0.1
    done

# Transfer trimmed files to $ADREM_FOLDER folder
mv $RAW_FOLDER/*remadapt* $REMADAPT_FOLDER
