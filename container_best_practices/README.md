# Best practices to deploy Singularity containers

### BioCommons Pathfinder
### by Marco De La Pierre, Pawsey Supercomputing Centre


## Singularity version

I am assuming Singularity version **3.3.0** or higher in this document. The syntax, scripts and container images hereby mentioned should mostly work with older ones, but there might be issues.  
Versions prior to 3.0.0 use different image formats.  
All versions prior to 3.3.0 that I have tested (2.5.1, 3.0.1, 3.2.1) had bugs in the way they enforce configuration of image cache/storage paths. I.e. this applies to the expected behaviours when using variables `SINGULARITY_CACHEDIR` and `SINGULARITY_PULLFOLDER`.  
I would kindly ask sites with older versions to proceed with an update.


1. [User configuration for Singularity](Configuration.md)

2. [Setting up container images for your applications](SettingUp.md)

3. [Embedding Singularity syntax to run containers](Running.md)

4. [Appendix: summary of basic Singularity commands](Appendix.md)
