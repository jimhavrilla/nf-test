# nf-test
A small tutorial repo for nextflow practice with the lab

## Prerequisites

You need Java 8 or higher to run `nextflow`.  Also `bash > 3.2` (pretty easy to meet requirement).

`wget -qO- https://get.nextflow.io | bash` will install nextflow by creating a binary executable you can just move to a folder in your `$PATH`.

If you want to try with `docker` or `sge` you will need docker installed or to run it on the CHOP cluster with Sun Grid Engine.

## Explanation of how it works

This simple example uses three fake PheWAS output files in the folder `example` and combines only the genome-wide significant SNPs (`<5e-8`) into a file, while labeling the phenotype files they came from (as is the case when running PheWAS by phenotype with PLINK or Hail.is).

Simply run:

```
nextflow run pvals.nf
```

and it will make a file, `significantsnps.txt`, that meets the abovementioned requirements in the working directory.  You can also run this on a CentOS image on the Mac or Windows WSL for example using (after `docker pull centos`):

```
nextflow run pvals.nf -with-docker centos
```

If you have a different image (tested on MacOS and DigitalOcean Droplet) required for each process in your pipeline, you can just add `container 'image_name'` under each process like so:

```
process significant {
  container 'centos'
  input:
```


If on the CHOP cluster (tested on Biocluster), you can just create a nextflow.config file or add the information under the process with:

```
process significant {
  executor='sge'
  queue='all.q'
  clusterOptions = '-V -cwd -l virtual_free=2G -S /bin/bash'
```
