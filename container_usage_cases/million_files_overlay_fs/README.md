# Handling large numbers of files using Singularity Overlay FS

## Example of an Albacore basecalling run

* Lustre bare metal: 72 hours
* Singularity OverlayFS: 19 hours

Scripts:
* [`prep.sh`](prep.sh): create the filesystem image
* [`job.sh`](job.sh): SLURM submission script
* [`wrapped.sh`](wrapped.sh): wrapped script called by the SLURM script

The scripts assume the relevant paths are bind mounted by Singularity using the variable `SINGULARITY_BINDPATH` (comma-separated list of paths).

This is just a test implementation.  
Could be improved by taking preparation and untarring/tarring scripts out of the pipeline.  
Also, it is possible to get rid of the wrapped script.
 
