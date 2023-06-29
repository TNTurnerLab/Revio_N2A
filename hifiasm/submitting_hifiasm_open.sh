#!/bin/bash
# Tychele N. Turner, Ph.D.
# Last update: June 28, 2023

bsub -R 'span[hosts=1] rusage[mem=2500G]' -g /tychele/VGP -n 50 -M 2500G -q tychele -G compute-tychele -oo neuro2a_hifiasm.oo -a "docker(tychelewustl/hifiasm:version2)" sh running_hifiasm_Neuro2a_revio.sh

