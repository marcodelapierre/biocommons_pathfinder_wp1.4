#!/bin/bash -l
 
#SBATCH --job-name=prep
#SBATCH --output=%x.out
#SBATCH --partition=workq
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --export=NONE
 
module load singularity/3.3.0
 
singularity exec docker://ubuntu:18.04 bash -c " \
  mkdir -p overlay_tmp/upper && \
  dd if=/dev/zero of=my_overlay count=314572800 bs=1024 && \
  mkfs.ext3 -d overlay_tmp my_overlay && rm -rf overlay_tmp \
  "
