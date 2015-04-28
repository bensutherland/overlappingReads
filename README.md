*Currently under development.*

# overlappingReads
used as a pipeline to quality trim, then collapse overlapping reads (e.g. paired-end where insert size is less than the length of R1 + R2)

When paired end data is overlapping, it can improve assemblies to collapse the two reads into a single read
prior to use in an assembler.

Outcome: a combination of single-end (< ~R1+R2) length and paired end data, depending on how overlapping the reads are.
