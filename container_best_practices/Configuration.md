[Back to Summary](README.md)

## User configuration for Singularity

There are some useful Singularity behaviours that can be configured simply by setting environment variables. Note that in HPC centres system administrators might have already taken care of some of these settings.


### Host directory mounting

By default, Singularity only mounts (i.e. makes available) in the container the Host current directory from where the singularity command is issued. This can be limiting every time you need to access files in other directories. You can mount additional directories at runtime with the `-B <dir1>,<dir2>,..` flag, but there's a handy variable for directories that you know you're always going to need.  
```
export SINGULARITY_BINDPATH=<dir1>,<dir2>,..
```

For instance, HPC centres typically offer scratch and storage volumes. E.g. Magnus/Zeus at Pawsey have `/group` and `/scratch` (note the comma separated list of directories):
```
export SINGULARITY_BINDPATH="/group,/scratch"
```

As a second example, Raijin at NCI has `/short`:
```
export SINGULARITY_BINDPATH="/short"
```

In Cloud systems, people often set up data volumes, which it can be convenient to mount through this environment variable.


### Cache location

When Singularity pulls/builds container images, it needs a cache to store intermediate components. By default, this cache is under the user home directory, `~/.singularity`. In contexts such as HPC centres use of home directories is often discouraged (with strict storage quotas in place), so it can be convenient to redefine this location, pointing to a volume where user quota is larger.

This would be under the `/group` filesystem at Pawsey:
```
export SINGULARITY_CACHEDIR="/group/<project>/<user>/.singularity>"
```

or under `/short` at NCI:
```
export SINGULARITY_CACHEDIR="/short/<project>/<user>/.singularity>"
```

On the Cloud, depending on how you've setup your virtual machine, you might want to keep on using the default home location, or set a customised one under a different volume. If you have a persistent volume available for data storage, you might want to use that to store image caches as well.


### Image store location

Singularity has two behaviours for storing container images.  
When downloading an image right while running it (i.e. via `singularity exec` or `run`), the image will always be stored in the cache location.  
When downloading through the `singularity pull` command, the image will be stored in the current directory by default.

This latter default can be changed depending on your personal preferences. Having images stored in the current directory is handy to use them, but can result in many duplicates of the same image throughout your directory tree.  
The alternative is to define a specific, unique location to store images. This keeps things tidy and allows you to always know where to find your downloaded images.

As above for the cache, in HPC centres it would be best to avoid the home directory, and so I would recommend using `/group` at Pawsey:
```
export SINGULARITY_PULLFOLDER="/group/<project>/<user>/.singularity/images"
```

and `/short` at NCI:
```
export SINGULARITY_PULLFOLDER="/short/<project>/<user>/.singularity/images"
```

On the Cloud, similar to the discussion for cache, you might consider different locations depending on your preferred setup. If you have a persistent volume available for data storage, you might want to use that to store container images as well.

Note that you will need to ensure that the specified location for the image store actually exists (if not, create it with `mkdir` once and for all).

Once you have the store directory set up using this variable, and some pulled containers, you can execute them either with the standard notation:
```
singularity exec docker://ubuntu:18.04 echo 'hello world'
```
or by referring to the image filename in the store dir:
```
singularity exec $SINGULARITY_PULLFOLDER/ubuntu_18.04.sif echo 'hello world'
```


### Bash completion

If you like to benefit from automatic `<Tab>` completion for Singularity commands and options, you need first to identify the installation directory for singularity, e.g.:
```
$ which singularity
/usr/local/bin/singularity
```

The root install directory is `/usr/local` in this case, so you can run the following to enable bash completion:
```
SINGULARITY_DIR="/usr/local"
. ${SINGULARITY_DIR}/etc/bash_completion.d/singularity
```


### Customise your .bash_profile

You can make all of the settings above available at shell login by adding the corresponding commands in your `~/.bash_profile`.  
For instance, these are the recommended additions for Zeus at Pawsey:
```
export SINGULARITY_BINDPATH="/group,/scratch"

export SINGULARITY_CACHEDIR="${MYGROUP}/.singularity>"
export SINGULARITY_PULLFOLDER="${MYGROUP}/.singularity/images>"

. /pawsey/sles12sp3/devel/sandybridge/gcc/4.8.5/singularity/3.3.0/etc/bash_completion.d/singularity
```
Note that you need to ensure the store dir exists:
```
mkdir -p ${MYGROUP}/.singularity/images
```

[Back to Summary](README.md)