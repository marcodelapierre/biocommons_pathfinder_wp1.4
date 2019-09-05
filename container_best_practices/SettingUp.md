[Back to Summary](README.md)


## Setting up container images for your applications

### Paradigms for containerisation

You can think of two approaches here: one container per application, or one container with the full software stack required for a given workflow. Different people take different approaches in this regard. I will here outline arguments for using both, depending on the type of workflow you need to run.

1. Workflow using a stack of stand-alone packages  

   A. Pipeline backbone (i.e. pipeline scripts) absent or small  
      Using one container per package here has the big advantage of modularity, so that if you need to modify the workflow and change some of the packages you can just replace the required containers, rather than having to modify a large, monolithic container.  
      The minor drawback is that you don't have a single digital object to share for collaboration/reporting; however, this can be simply replaced by the list of adopted containers (or even a download script that gets them all!).  

   B. Articulated pipeline backbone (i.e. large, integrated pipeline scripts)  
      When a project ships with a structured set of pipeline scripts, un-containerised, using a set of softwares, it might be more convenient to prepare a single container with the scripts and all the dependencies, rather than radically modifying the pipeline code to make use of containers. With all of the deps inside the container, the scripts can be almost left unchanged.

2. Workflow making use of Python or R packages
   In this case the software stack is made up of a set of either Python or R libraries. In this case it can be definitely more convenient to make a single container with all the required packages for the given workflow. This will ensure consistency in dependencies versions across the various required packages.


### Adopt, Adapt, Build

I find this approach to work quite well when moving to a containerised software stack.

1. *Adopt*  
   Given a required package, I typically look for it in container image registries online: [hub.docker.com], [quay.io] and, quite conveniently for bioinformatics, [http://biocontainers.pro/#/registry]. The **Biocontainers** project has made the great effort of making thousands of packages in this domain available as containers. Most of the [Bioconda](http://bioconda.github.io) packages are nowadays automatically containerised and pushed as Biocontainers.  
   So you can just search for a package in these registries. If you find it, you often get to choose among different versions. Pick the latest one, or a specific one if you need to, and note down the container image full name. Pull it and ensure the relevant executables work by running a test command (e.g. using the `--help` flag). Oftentimes this is all you need to be ready to run a standalone package.

2. *Adapt*  
   Sometimes a given package



### Building with Docker or Singularity?


### Install script for required containers


### Containers and reference databases



[Back to Summary](README.md)
