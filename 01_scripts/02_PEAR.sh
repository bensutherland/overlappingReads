#!/bin/bash
# decompresses paired fastq.gz files and uses PEAR to collapse into single reads when possible
# removes decompressed reads, then moves files to the binned folder

# Global variables
ADREM_FOLDER="03_adapter_removed"
BINNED_FOLDER="04_binned_pairs"
PEAR="/usr/local/bin/pear"

## Filtering and trimming data with trimmomatic
ls -1 $ADREM_FOLDER/*.fastq.gz | \
    perl -pe 's/R[12]\_001_remadapt.fastq\.gz//' | \
    grep -vE "paired|single" | \
    sort -u | \
    while read i
    do
      echo $i \
     # Decompress reads
      echo "Decompressing Reads"
      gunzip -c "$i"R1_001_remadapt.fastq.gz > "$i"R1_001_remadapt.fastq
      gunzip -c "$i"R2_001_remadapt.fastq.gz > "$i"R2_001_remadapt.fastq
      $PEAR -f "$i"R1_001_remadapt.fastq -r "$i"R2_001_remadapt.fastq -o "$i"output \
   # Remove Decompressed Reads
     #echo "Removing decompressed reads"
     #rm "$i"R1_001_remadapt.fastq
     #rm "$i"R2_001_remadapt.fastq
    done

mv $ADREM_FOLDER/*assembled* $BINNED_FOLDER/ 
mv $ADREM_FOLDER/*discarded* $BINNED_FOLDER/
