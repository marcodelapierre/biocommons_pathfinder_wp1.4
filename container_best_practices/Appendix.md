[Back to Summary](README.md)


# Appendix: Singularity quick reference

## Singularity tutorial

A useful introductory tutorial by the Sylabs team can be found at [https://github.com/ArangoGutierrez/Singularity-tutorial].


## Summary of basic Singularity commands

1. Pull a container image:
```bash
singularity pull docker://ubuntu:18.04
```

2. Execute a command in a container:
```bash
singularity exec docker://ubuntu:18.04 echo 'hello world'
```

3. Run default container application, if defined, otherwise open a shell:
```bash
singularity run docker://ubuntu:18.04
```

4. Open a shell in a container:
```bash
singularity shell docker://ubuntu:18.04
```
enter `exit` to close.

5. See [Build a Container](https://sylabs.io/guides/3.3/user-guide/build_a_container.html) for details on building containers with Singularity.

If you have already got a local container image, you can use its filename with the keywords `exec`, `run`, `isntance`, `shell` (points 2-4 above). For instance for `exec`'uting a command:
```bash
singularity exec </path/to/image>/ubuntu_18.04.sif echo 'hello world'
```


[Back to Summary](README.md)
