#!/usr/bin/env nextflow

params.out = "$PWD/significantsnps.txt" // global variable for output

// this grabs files and puts it into a "channel," so that you can use the data in a process asynchronously
Channel.fromPath('example/pheno*.pvals').set{ pheno_ch }

process significant {
  input:
  file x from pheno_ch // each input file from the channel goes in to $x

  output:
  file 'snps' into result // stdout to the result channel

  script: // runs the script on each file in channel async
  """
  awk 'FNR>2{if (\$5<=5e-8){split(FILENAME,a,"."); print \$0,a[1]}}' $x > snps
  """
}

result
	.collectFile(name: params.out) 
