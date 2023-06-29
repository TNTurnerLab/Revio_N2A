#!/bin/bash
# Tychele N. Turner, Ph.D.
# Last update: June 28, 2023
# pbmm2 analysis

export PATH=/opt/conda/bin:$PATH

SAMPLE='Neuro2a_Revio'
REFERENCE='/path/to/reference/mm10.fa'
SMRTcell1='/path/to/fastq/XTTWU_20230426_R84050_PL100293497-1_A01.default.bam'
SMRTcell2='/path/to/fastq/XTTWU_20230426_R84050_PL100293497-1_B01.default.bam'
SMRTcell3='/path/to/fastq/XTTWU_20230426_R84050_PL100293497-1_C01.default.bam'
TMPDIR='/path/to/temp/'

pbmm2 align --preset CCS --bam-index BAI --sort -j 21 -m 8G -J 8 "$REFERENCE" "$SMRTcell1" "$SAMPLE"_SMRTcell1.movie.bam
pbmm2 align --preset CCS --bam-index BAI --sort -j 21 -m 8G -J 8 "$REFERENCE" "$SMRTcell2" "$SAMPLE"_SMRTcell2.movie.bam
pbmm2 align --preset CCS --bam-index BAI --sort -j 21 -m 8G -J 8 "$REFERENCE" "$SMRTcell3" "$SAMPLE"_SMRTcell3.movie.bam

samtools merge -@ 29 "$SAMPLE".bam "$SAMPLE"_SMRTcell1.movie.bam "$SAMPLE"_SMRTcell2.movie.bam "$SAMPLE"_SMRTcell3.movie.bam

samtools sort -o "$SAMPLE".final.bam --output-fmt=BAM --reference "$REFERENCE" -@ 29 -m 8G "$SAMPLE".bam

samtools index "$SAMPLE".final.bam

