# Analyses peadiatric Sjogren cohort

This repository contains the code used in the analysis the study 'Identifying mechanisms contributing to the development of Sjögren's in children'. It adheres to the following structure:

```
├───combined_analysis_pipeline
│       ├───containers
│       ├───modules
│       ├───scripts
│       ├───sjogren_analysis.nf
│       ├───flowchart.png
│       └───sjogren_config.cfg
├───explorative_result_analysis
├───gsva_analysis
├───resources
├───LICENSE
└───README.md
```

## The analyses

GSVA analysis and the explorative result analysis can be found in their respectful directory. The GSVA analysis contains the steps that were done for this analysis, and some plotting of the results.

The explorative result directory contains the results of a PCA done on the results of a differential gene expression analysis and the results of a PCA done on the results of the GSVA analsyis.

A table of all the libraries used in these analyses can be found in the resources directory as the 'table_of_tools.png'

## Combined analysis pipeline

This is the pipeline that was used to find variants of interests by combining the results of the different types of analyses that were done.

### Prerequisites

Before running this pipeline. Please make sure you have the following libraries available:
- [Nextflow(version 24.04.4)](https://www.nextflow.io/)
- [Apptainer(version 1.3.0-1.el9)](https://apptainer.org/)
- [Python(version 3.9.18)](https://www.python.org/downloads/release/python-3918/)

A few tools have been used to generate input. Below you'll find the tools used and their versions. Beware, using tools with different versions may result in different output.
- [VIP(version 8.2.0)](https://github.com/molgenis/vip/releases/tag/v8.2.0)
- [RNA-sequecning pipeline(git hash: a379313)](https://github.com/molgenis/RNA_outlier_pipeline)

### Parameters

Before running the pipeline a few parameters will need to be set. These parameters can be found in the sjogren_config.cfg file.

- input: this parameter should contain the path to the directory that contains the VIP generated vcfs.
- linking_table: this parameter should contain the path to the file that links the RNA patient IDs to the DNA patient IDs.
- rna_dir: this parameter should contain the path to the directory that contains the OUTRIDER and FRASER results. Within this directory, the results should be stored in the following structure:
```
├───rna_results
│       ├───fraser
|       |    └───[ID]_result_table_fraser.tsv
|       └───outrider
|       |    └───[ID]_result_table_outrider.tsv
```
- differential_result: this parameter should contain the path to the file that contains differential gene expression analysis results. The genes of interest are expected in the second column.
- pathway_result: this parameter should contain the path to the file that contains pathway expression analysis results. The genes of interest are expected in the second column.
- output: this parameter should contain the path to the directory where you want the results to be written to.

### How to run

After making sure all the dependencies are installed correctly, you can run the pipeline using the following instructions:

1. Set the parameters in the config in accordence to the above description

2. Once the parameters are set, choose between running it locally or running it using slurm. The profiles have already been set, but one can choose to edit these according to preference.

3. Now you are ready to run the pipeline. In your terminal, you should be able to type something like this:
```
nextflow run sjogren_analysis.nf -c ./sjogren_config.cfg -profile [slurm OR local]
```

## Data availability
The data that is used in this study can be accessed upon request at the Rheumatology department of the UMCG.
