### Hifiasm analysis workflow
### Tychele N. Turner, Ph.D.
### Last update: June 28, 2023
### These analyses were run on our WashU LSF server

1. Run the hifiasm assembly (this is similar for running all the different iterations, the iterations just differ by the fastq input)
sh submitting_hifiasm_open.sh

2. Get assembly metrics resulting gfa files
bsub -R 'span[hosts=1] rusage[mem=50G]' -g /tychele/dv -n 1 -M 50G -G compute-tychele -q general-interactive -Is -a 'docker(tychelewustl/gfatools_caln50:version1)' sh post_hifiasm_neuro2a.sh

