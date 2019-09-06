[Back to Summary](README.md)


# Setting up container images for your applications

## Paradigms for containerisation

You can think of two approaches here: one container per application, or one container with the full software stack required for a given workflow. Different people take different approaches in this regard. I will here outline arguments for using both, depending on the type of workflow you need to run.

### A) Workflow using a stack of stand-alone packages  

1. Small or absent pipeline backbone (i.e. pipeline scripts)  
   Using one container per package here has the big advantage of modularity, so that if you need to modify the workflow and change some of the packages you can just replace the required containers, rather than having to modify a large, monolithic container.  
   The minor drawback is that you don't have a single digital object to share for collaboration/reporting; however, this can be simply replaced by the list of adopted containers (or even a download script that gets them all!).  

2. Articulated pipeline backbone (i.e. large, integrated pipeline scripts)  
   When a project ships with a structured set of pipeline scripts, un-containerised, using a set of softwares, it might be more convenient to prepare a single container with the scripts and all the dependencies, rather than radically modifying the pipeline code to make use of containers. With all of the dependencies inside the container, the scripts can be almost left unchanged.

### B) Workflow making use of Python or R packages  

In this case the software stack is made up of a set of either Python or R libraries. In this case it can be definitely more convenient to make a single container with all the required packages for the given workflow. This will ensure consistency in dependencies versions across the various required packages.


## Adopt, Adapt, Build

I find this approach to be quite well suited when seeking to move to containerised software.

### *Adopt*

Given a required package, I typically look for it in container image registries online: [hub.docker.com], [quay.io] and, quite conveniently for bioinformatics, [http://biocontainers.pro/#/registry]. The **Biocontainers** project has made the great effort of making thousands of packages in this domain available as containers. Most of the [Bioconda](http://bioconda.github.io) packages are nowadays automatically containerised and pushed as Biocontainers.  
So you can just search for a package in these registries. If you find it, you often get to choose among different versions. Pick the latest one, or a specific one if you need to, and note down the container image full name. Pull it and ensure the relevant executables work by running a test command (e.g. using the typical `-h` or `--help` flags to print infos on general usage). Oftentimes this is all you need to be ready to run a standalone package.

### *Adapt*  

Sometimes a given package requires some additional utilities/packages, which are not shipped in the container you have found online. This often happens when working with Python/R packages, and is a good case for taking such container as a starting point to build your own customised one.  
Introductory tutorial modules on writing recipe files can be found [here for Singularity](https://github.com/ArangoGutierrez/Singularity-tutorial/blob/master/BUILD_RUN.md) and [here for Docker](https://pawseysc.github.io/container-workflows/05-build-intro/index.html).

### *Build*  
Some packages haven't been ported into containers yet. Then this is the case for creating an image from scratch. You'll need to pick a starting image, [hub.docker.com] has got plenty of good ones, and you want to use different ones depending on the package.

1. For a C/C++/Fortran application, start with a plain Linux image. `ubuntu:18.04` and `debian:10` are both good choices, as if you need to install additional dependencies you'll find plenty of instructions on the Web for these Linux distributions. If the package is available through *conda*, you can use `continuumio/miniconda3:4.6.14` as a starting point.

2. For Python packages that can be installed through *pip* , you can use `python:3.7` or `python:3-slim` (minimal installation) as a starting image. As seen above, if the package is available through *conda*, you can use `continuumio/miniconda3:4.6.14` as a starting point. If you need a Jupyter notebook, consider the series of images by `jupyter/`, e.g. `jupyter/scipy-notebook:latest` if you need to use numpy/scipy. If numerical performances are crucial, there are optimised Python containers developed by Intel, e.g. `intelpython/intelpython3_core:2019.4`.

3. For R packages, you can use `rocker/r-ver:3.6.1`. If you need RStudio, consider `rocker/rstudio:3.6.1`, and if you need the *Tidyverse* collection of packages, then there is `rocker/tidyverse:3.6.1`.

Once you've picked a starting image, collect or work out the full set of commands required to install the package, and embed them into the container recipe file.


## Tags and digests

**Tags** are a way to label different container images corresponding to the same repository (i.e. typically same application). As an example, in the image `ubuntu:18.04` the tag is `18.04`.  
It's entirely up to who built the container to decide how to pick tags. Typically they include information on the software version (as in this Ubuntu example), but also on the build history of the container. E.g. the latest BLAST Biocontainers has tag `2.9.0--pl526h979a64d_3`. There can be several builds for the same version, to account for updated dependencies, or bug fixed in the container itself.  
Pick the tag corresponding to the package version you need, or to the latest version. If there are multiple tags for the same version, try and pick the most recent as it's hopefully more refined than previous ones.  
Often images offer a tag named `latest` as a shortcut to the most recent build. The image corresponding to this tag will change often as a result of this naming convention, so distinct image pulls along time can result in different images being downloaded, potentially impacting on reproducibility. You should avoid using `latest` tags unless you have no choice.

**Digests** are unique alphanumeric strings assigned to each container image. Because they univocally identify images, they are the best way to enforce reproducibility. Use them in substitution to tags if this a vital aspect for you. For instance, as of today the image `ubuntu:18.04` can be referred using its digest via:
```
ubuntu@sha256:d1d454df0f579c6be4d8161d227462d69e163a8ff9d20a847533989cf0c94d90
```


## Building with Docker or Singularity?

This is a legitimate question even if you are using only Singularity to manage and run your containers. In fact, both choices come with pros and cons.  
Using Singularity provides a consistent user experience across all the steps of container usage. Also, making a Singularity recipe file out of a shell script requires few modifications. Singularity has also a remote build feature, that allows to submit builds from an HPC cluster.  
On the other hand, Docker build is a multi step process that makes large use of caching to reduce build and development times. Also, Docker containers can be run by both Docker and Singularity.  

At present I have no final answer on which way is the best to go. On a Linux box (laptop, workstation, cloud) they can be installed together to coexist, so you might want to give both a try and find your preferred build approach.


## Containers and reference databases

Reference databases in bioinformatics (and other domains) are often quite large in size (tens of GB if not more), and are updated frequently. For these reasons, it's not a good idea to package them in a container image with the corresponding application, as they would make them hard to transfer, and very much prone to become outdated.  
It is much better to install ref. databases in the host machine, and then mount them at runtime to the container.


[Back to Summary](README.md)
