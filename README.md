Bio-RNASeq
==========

Bio-RNASeq calculates expression values (RPKM) from any given BAM file.  
This application takes in an aligned sequence file (BAM) and a corresponding annotation file (GFF) and creates a spreadsheet with expression values.
The BAM must be aligned to the same reference that the annotation refers to and must be sorted.

The RPKM values are calculated according to two different methodologies:

1) total number of reads on the bam file that mapped to the reference genome;

2) total number of reads on the bam file that mapped to gene models in the reference genome.

The *expression.csv file will contain both datasets. 

Coverage plots compatible with Artemis will also be produced. You can download Artemis here:

http://www.sanger.ac.uk/resources/software/artemis/
 
  

SYNOPSIS
========

rna_seq_expression -s [filename.bam] -a [filename.gff] -p [standard|strand_specific] -o [./foobar]

USAGE
=====

-s|sequence_file             - aligned BAM file

-a|annotation_file           - annotation file (GFF)

-p|protocol                  - standard|strand_specific

-o|output_base_filename      - Optional: base name and location to use for output files

-q|minimum_mapping_quality   - Optional: minimum mapping quality

-c|no_coverage_plots         - Optional: Dont create Artemis coverage plots

-i|intergenic_regions        - Optional: Include intergenic regions

-b|bitwise_flag              - Optional: Only include reads which pass filter

-h|help                    - print this message


REQUIRES
========

The samtools executable must be set in your path. You can download samtools here:

https://github.com/samtools


You will also need to download samtools v0.1.18 and build it on your system. Bio-RNASeq makes use of the Samtools v0.1.18 C API. You can get it here:

https://github.com/samtools/samtools/tree/0.1.18

Once you've downloaded this, in a bash terminal, in the samtools v0.1.18 directory, run

	~$ make

__NOTE:__ You don't need to run `make install`. You don't need to install the older version of samtools on your system.

When `make` finishes, you will need to set a couple of environment variables

	export PATH=[path_to]/Bio-RNASeq/bin:$PATH
	export PERL5LIB=[path_to]/Bio-RNASeq/lib:$PERL5LIB
	
Now set the `$SAMTOOLS` environment variable to point to the directory where you built samtools v0.1.18

	export SAMTOOLS=[path_to]/samtools_0.1.18/


Create a directory called  `_Inline` wherever you want. And set `$PERL_INLINE_DIRECTORY`

	export PERL_INLINE_DIRECTORY=[path_to]/_Inline

You're now ready to run your RNA Seq analysis using Bio-RNASeq.


__NOTE:__

You can easily put all the above export statements into a bash script. You will need to source it before you can run Bio-RNASeq.

As an example, the file

	bio_rnaseq_environment_setup.sh	

Looks like this

	export PATH=/Users/user/work/Bio-RNASeq/bin:$PATH
	export PERL5LIB=/Users/user/work/Bio-RNASeq/lib:$PERL5LIB
	export PERL_INLINE_DIRECTORY=/Users/user/test_RNASeq/_Inline
	export SAMTOOLS=/Users/user/work/samtools/

Whenever `user` needs to run an RNA Seq analysis with Bio-RNASeq, this bash script will need to be sourced

	~$ source bio_rnaseq_environment_setup.sh

Now `user` can run this application in a bash terminal from wherever he is.