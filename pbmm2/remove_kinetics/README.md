#!/bin/bash
# Tychele N. Turner, Ph.D.
# Last update: June 28, 2023
# analysis to remove kinetics
# These analyses were run on our lambda workstation

# instantiate the docker

## docker run -it  -v "/home/tychele/Documents/:/home/tychele/Documents/" -v "/data/:/data/" tychelewustl/pbmm2samtools:1.10.0 /bin/bash

samtools view -@ 100 -b -x fp -x fi -x rp -x ri ../Neuro2a_Revio.final.bam > Neuro2a_Revio.final.no.kinetics.bam

samtools view -@ 100 -b -x fp -x fi -x rp -x ri ../Neuro2a_Revio_SMRTcell1.movie.bam > Neuro2a_Revio_SMRTcell1.movie.no.kinetics.bam

samtools view -@ 100 -b -x fp -x fi -x rp -x ri ../Neuro2a_Revio_SMRTcell2.movie.bam > Neuro2a_Revio_SMRTcell2.movie.no.kinetics.bam

samtools view -@ 100 -b -x fp -x fi -x rp -x ri ../Neuro2a_Revio_SMRTcell3.movie.bam > Neuro2a_Revio_SMRTcell3.movie.no.kinetics.bam

for i in *bam; do samtools index -@ 100 "$i"; done

