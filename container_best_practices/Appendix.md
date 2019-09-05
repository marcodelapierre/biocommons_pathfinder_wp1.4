[Back to Summary](README.md)


## Appendix A: Singularity tutorial

A useful introductory tutorial by the Sylabs team can be found at [https://github.com/ArangoGutierrez/Singularity-tutorial].


## Appendix B: summary of basic Singularity commands

1. Pull a container image (saved in current directory or set path, see below):
```
singularity pull docker://ubuntu:18.04
```

1. Execute a command in a container (if not downloaded, saved in cache, see below):
```
singularity exec docker://ubuntu:18.04 echo 'hello world'
```

3. Open a shell in a container (if not downloaded, saved in cache, see below):
```
singularity shell docker://ubuntu:18.04
```
enter `exit` to close.

4. Run default container application, if defined, otherwise open a shell (if not downloaded, saved in cache, see below):
```
singularity run://ubuntu:18.04
```

5. See [Build a Container](https://sylabs.io/guides/3.3/user-guide/build_a_container.html) for details on building containers with Singularity.

If you have already got a local container image, you can use its filename to execute it.

A. Execute a command:
```
singularity exec </path/to/image>/ubuntu_18.04.sif echo 'hello world'
```

B. Open a shell:
```
singularity shell </path/to/image>/ubuntu_18.04.sif
```

C. Run default application:
```
singularity run </path/to/image>/ubuntu_18.04.sif
```
or
```
</path/to/image>/ubuntu_18.04.sif
```


[Back to Summary](README.md)
