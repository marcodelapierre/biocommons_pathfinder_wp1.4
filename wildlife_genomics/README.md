# Wildlife Genomics project


## Containerised software

The script `download-containers.sh` can be used to pull these containers locally, provided Singularity is available:
```bash
./download-containers.sh singularity
```

- Available as Biocontainers
    * Quast
    * Busco
    * RSEM
    * Trinotate
    * MAKER
    * Trinity - we might need to add GNU parallel

- New containers  

    * Supernova  
      [Container image](https://cloud.docker.com/u/marcodelapierre/repository/docker/marcodelapierre/supernova)  
      [Dockerfile](https://github.com/marcodelapierre/md-dockerfiles/blob/master/bio/supernova/Dockerfile)  

    * Juicer - at the moment CPU only  
      [Container image](https://cloud.docker.com/u/marcodelapierre/repository/docker/marcodelapierre/juicer)  
      [Dockerfile](https://github.com/marcodelapierre/md-dockerfiles/blob/master/bio/juicer/Dockerfile)  
      [Wrapper shell script](https://github.com/marcodelapierre/md-dockerfiles/blob/master/bio/juicer/juicer-singularity.sh)  


## Data analysis workflows

- [SIH Trinity assembly - optimised for Raijin](https://github.com/Sydney-Informatics-Hub/SIH-Raijin-Trinity)


## Portable data analysis workflows

**work in progress**

- Trinity assembly - nf

- Juicer (HiC assembly)
