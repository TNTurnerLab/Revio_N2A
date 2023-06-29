#!/bin/bash

bsub -R 'span[hosts=1] rusage[mem=300G]' -g /tychele/dv -n 30 -M 300G -q general -G compute-tychele -oo map_reads.oo -a "docker(tychelewustl/pbmm2samtools:1.10.0)" sh map_reads.sh
