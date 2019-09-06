[Back to Summary](README.md)


# Embedding Singularity syntax to run containers

There are various ways you can take to implement container syntax in your command typing and scripting. I will briefly outline my impressions on the ones I have tested so far.


## Using Singularity syntax

Singularity offers a relatively compact syntax to execute software from containers. This implies not much of additional typing when running interactively on a shell terminal, and minor modifications to batch scripts.  
There are two main ways for executing containerised applications with Singularity.

### A. Execute command

Suppose you want to run `blastp --help` from a BLAST container. Then you can use:
```bash
singularity exec docker://quay.io/biocontainers/blast:2.9.0--pl526h979a64d_3 blastp --help
```

If you have pulled the image locally, then in alternative you can refer to the image file:
```bash
singularity exec <path/to/image>/blast_2.9.0--pl526h979a64d_3.sif blastp --help
```
Note the tag `:` is substituted by `_`, and also note the `.sif` extension, for Singularity version 3 or higher.

The command syntax itself is pretty compact, the only complication being having to type the whole image name.  
During interactive work, this can be relieved by using a local store directory for image files, as then you can take advantage of `Tab` completion. For information on local store dir, i.e. the environment variable `SINGULARITY_PULLFOLDER`, see [Admin and user configurations for Singularity](Configuration.md).  
When writing batch script, usage of a local store dir can be handy again, as it provides a unified location to browse when looking for image filenames.

This solution always works, regardless any default commands that might be defined in the container recipe file. It is just a bit wordy.


### B. Run default application (if any)

Both Dockerfiles and Singularity recipe files allow to define a default application to be run from within a given container image (using the `ENTRYPOINT` and `runscript` option, respectively). So imagine you've setup a BLAST container with `blastp` as default entrypoint/runscript. Then you can use:
```bash
singularity run docker://quay.io/biocontainers/blast:2.9.0--pl526h979a64d_3 --help
```
or, with a local image file:
```bash
singularity run <path/to/image>/blast_2.9.0--pl526h979a64d_3.sif --help
```
or, again with a local image file, you can treat as a binary:
```bash
<path/to/image>/blast_2.9.0--pl526h979a64d_3.sif --help
```
Note how you have to skip the `blastp` command, as it has been already defined as default in the container recipe.  
Note also how the last option is particularly powerful, in terms of reduced typing.

Although intriguing, this runtime mode needs to be handled with care. In fact, the command will succeed if a entrypoint/runscript has been defined at image build time, but will otherwise fail or yield unexpected results.  
So, if you want to use this as a general approach, you should ensure all the container images you're using have an entrypoint/runscript, or otherwise customise them. In addition, for application packaging a set of executables rather than a single one, you'll still have to pick just one for this mode.

To me this mode is more like one to be used for specific application cases rather than in general.


## Wrapper scripts

If you want to save typing in both interactive and batch sessions, you might want to wrap a shell script around your container. To take the BLAST example again, you might have a `blastp.sh` script that looks like:
```bash
#!/bin/bash

singularity exec <path/to/image>/blast_2.9.0--pl526h979a64d_3.sif blastp "$@"

```
This script will execute `blastp` and pass any arguments onto it, so that the following will work as expected:
```bash
<path/to/script>/blastp.sh --help
```

Depending on the specific software or user case, you can embed in the script any required environment variables or additional Singularity flags.

To scale this solution out to lots of packages, you could create a script store directory `SCRIPT_DIR` and add it to your `PATH`:
```bash
export PATH=${SCRIPT_DIR}:$PATH
```

This can be a simple yet very powerful upgrade to the plain use of Singularity syntax. An automated script generator can be conveniently setup, as well.


### Wrapper scripts with automation and modules

You might like the look and feel of environment modules, i.e. the `module load`/`unload` syntax to make applications available for execution. Then, have a look at the interesting work done by Alexis Lucattini (currently at AGRF in Melbourne, VIC) to automate module/wrapper building for containerised applications: [https://github.com/alexiswl/quay_containers].


## Scientific workflow tools

If you design and run lots of structured analysis pipelines, then using a workflow tool can really make your day. Beside improving productivity (less typing compared to bash!), reproducibility, portability and scalability of your workflows, some of the most popular tools nowadays also come with built-in support for containers, including the Singularity runtime.  
This means that, if using them, you won't even have to know how to operate Singularity, as the workflow engine will take care of that for you. All you will need is to provide container image names, and tell the tool to use them!  
At the time of writing, the most popular command line based scientific workflow tools are (in strict alphabetic order) [Nextflow](https://www.nextflow.io) and [Snakemake](https://snakemake.readthedocs.io).


[Back to Summary](README.md)
