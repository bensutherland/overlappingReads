#!/bin/bash
# remove adapter sequences from reads using cutadapt
# point to the trimmomatic.jar in Global variables

# Global variables
ADREM_FOLDER="03_adapter_removed"
BINNED_FOLDER="04_binned_pairs"
PEAR="/usr/local/bin/pear"

# Filtering and trimming data with trimmomatic
ls -1 $ADREM_FOLDER/*.fastq.gz | \
    perl -pe 's/R[12]\_001_remadapt.fastq\.gz//' | \
    grep -vE "paired|single" | \
    sort -u | \
    while read i
    do
      echo $i
      # Decompress reads
      echo "Decompressing Reads"
      gunzip -c "$i"R1_001_remadapt.fastq.gz > "$i"R1_001_remadapt.fastq
      gunzip -c "$i"R2_001_remadapt.fastq.gz > "$i"R2_001_remadapt.fastq
      $PEAR -j 7 -y 75G \
        -f "$i"R1_001_remadapt.fastq -r "$i"R2_001_remadapt.fastq \
        -o ./$BINNED_FOLDER/"$i"
    # Remove Decompressed Reads
      echo "Removing decompressed reads"
      rm "$i"R1_001_remadapt.fastq
      rm "$i"R2_001_remadapt.fastq
    done
