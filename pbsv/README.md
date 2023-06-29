### pbsv analysis workflow
### Tychele N. Turner, Ph.D.
### Last update: June 28, 2023
### These analyses were run on our lambda workstation

1. Run pbsv step 1 on each dataset
```
docker run -v "/data/:/data/" -v "/home/tychele/:/home/tychele/" tychelewustl/pbsv:2.9.0 pbsv discover /data/N2A_Revio/pbmm2/Neuro2a_Revio.final.bam /home/tychele/Documents/Revio_Testing_N2A/pbsv/Neuro2a_Revio.svsig.gz

docker run -v "/data/:/data/" -v "/home/tychele/:/home/tychele/" tychelewustl/pbsv:2.9.0 pbsv discover /data/N2A_Revio/pbmm2/Neuro2a_Revio_SMRTcell1.movie.bam /home/tychele/Documents/Revio_Testing_N2A/pbsv/Neuro2a_Revio_SMRTcell1.svsig.gz

docker run -v "/data/:/data/" -v "/home/tychele/:/home/tychele/" tychelewustl/pbsv:2.9.0 pbsv discover /data/N2A_Revio/pbmm2/Neuro2a_Revio_SMRTcell2.movie.bam /home/tychele/Documents/Revio_Testing_N2A/pbsv/Neuro2a_Revio_SMRTcell2.svsig.gz

docker run -v "/data/:/data/" -v "/home/tychele/:/home/tychele/" tychelewustl/pbsv:2.9.0 pbsv discover /data/N2A_Revio/pbmm2/Neuro2a_Revio_SMRTcell3.movie.bam /home/tychele/Documents/Revio_Testing_N2A/pbsv/Neuro2a_Revio_SMRTcell3.svsig.gz
```

2. Run pbsv step 2 on each dataset
```
docker run -v "/data/:/data/" -v "/home/tychele/:/home/tychele/" tychelewustl/pbsv:2.9.0 pbsv call --ccs /home/tychele/Data/Reference/mm10.fa /home/tychele/Documents/Revio_Testing_N2A/pbsv/Neuro2a_Revio.svsig.gz /home/tychele/Documents/Revio_Testing_N2A/pbsv/Neuro2a_Revio_Full_Dataset.var.vcf

docker run -v "/data/:/data/" -v "/home/tychele/:/home/tychele/" tychelewustl/pbsv:2.9.0 pbsv call --ccs /home/tychele/Data/Reference/mm10.fa /home/tychele/Documents/Revio_Testing_N2A/pbsv/Neuro2a_Revio_SMRTcell1.svsig.gz /home/tychele/Documents/Revio_Testing_N2A/pbsv/Neuro2a_Revio_SMRTcell1.var.vcf

docker run -v "/data/:/data/" -v "/home/tychele/:/home/tychele/" tychelewustl/pbsv:2.9.0 pbsv call --ccs /home/tychele/Data/Reference/mm10.fa /home/tychele/Documents/Revio_Testing_N2A/pbsv/Neuro2a_Revio_SMRTcell2.svsig.gz /home/tychele/Documents/Revio_Testing_N2A/pbsv/Neuro2a_Revio_SMRTcell2.var.vcf

docker run -v "/data/:/data/" -v "/home/tychele/:/home/tychele/" tychelewustl/pbsv:2.9.0 pbsv call --ccs /home/tychele/Data/Reference/mm10.fa /home/tychele/Documents/Revio_Testing_N2A/pbsv/Neuro2a_Revio_SMRTcell3.svsig.gz /home/tychele/Documents/Revio_Testing_N2A/pbsv/Neuro2a_Revio_SMRTcell3.var.vcf
```

3. Compress the vcfs
```
for i in *vcf ; do sudo docker run -v "/home/tychele/:/home/tychele/" tychelewustl/test2:cbs /opt/conda/bin/bgzip /home/tychele/Documents/Revio_Testing_N2A/pbsv/"$i"; done
for i in *vcf.gz ; do sudo docker run -v "/home/tychele/:/home/tychele/" tychelewustl/test2:cbs /opt/conda/bin/tabix -p vcf /home/tychele/Documents/Revio_Testing_N2A/pbsv/"$i" ; done
```

4. Get counts of pbsv
```
for i in *vcf.gz; do echo "$i"; zcat "$i" | grep -v '#' | wc -l; done
```

5. Save compressed vcfs in another directory (since they don't work with the survivor merger)
```
mkdir compressed_vcfs
cp *vcf.gz* compressed_vcfs/
rm *tbi
gunzip *vcf.gz
```

6. Run pbsv merge with SURVIVOR
```
ls /home/tychele/Documents/Revio_Testing_N2A/pbsv/*vcf > sample_files.txt
```

merge arguments for reference
```
File with VCF names and paths
max distance between breakpoints (0-1 percent of length, 1- number of bp)
Minimum number of supporting caller
Take the type into account (1==yes, else no)
Take the strands of SVs into account (1==yes, else no)
Disabled.
Minimum size of SVs to be taken into account.
Output VCF filename
```

```
docker run -v "/home/tychele/:/home/tychele/" tychelewustl/survivor:version2 /SURVIVOR-master/Debug/SURVIVOR merge /home/tychele/Documents/Revio_Testing_N2A/pbsv/sample_files.txt 10 1 1 1 0 50 /home/tychele/Documents/Revio_Testing_N2A/pbsv/Revio_N2A_merged_set.vcf
```

7. Generate a comparison for the datasets
```
sudo docker run -v "/home/tychele/:/home/tychele/" tychelewustl/survivor:version2 /SURVIVOR-master/Debug/SURVIVOR genComp /home/tychele/Documents/Revio_Testing_N2A/pbsv/Revio_N2A_merged_set.vcf 1 /home/tychele/Documents/Revio_Testing_N2A/pbsv/Revio_N2A_merged_set_genComp.txt
```
