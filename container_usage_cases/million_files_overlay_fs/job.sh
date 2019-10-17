#!/bin/bash -l
 
#SBATCH --job-name=basecall
#SBATCH --output=%x.out
#SBATCH --partition=longq
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=28
#SBATCH --time=4-00:00:00
#SBATCH --mem=120G
#SBATCH --export=NONE
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
 
# shifter definitions
module load singularity/3.3.0
albacore_cont="docker://genomicpariscentre/albacore:2.3.3"
unset XDG_RUNTIME_DIR
 
# job id
echo SLURM job id : $SLURM_JOB_ID
 
# definitions
export here=$(pwd)
export file_in="/group/pawsey0001/mdelapierre/pup/pup2018/monica/MonicaSam/PlantVirus_Monica/Nanopore/6.tar.gz"
export file_out="$here/pass.tar.gz"
export temp_dir="/mytmp"
 
# wrapped script
srun --export=ALL singularity exec -B /group,/scratch --overlay my_overlay $albacore_cont bash ./wrapped.sh
