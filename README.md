# OSeMOSYS Snakemake

A more complex example repository demonstrating the use of Snakemake for running parallel instances of OSeMOSYS.

## Installation

Install snakemake using conda into a new environment called `snakemake`:

```
conda create -c bioconda -c conda-forge -n snakemake python=3.6 snakemake-minimal
```

Then, activate the environment using `source activate snakemake` on Mac and Linux, or `activate snakemake` on Windows.

## Running the workflow

To run the workflow, using the command `snakemake --use-conda --cores 4`

## Plotting the workflow

To visualise the workflow, run the following rule: `snakemake plot_dag --use-conda  --cores 2`