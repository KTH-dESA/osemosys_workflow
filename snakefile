rule all:
	input: "processed_data/plot.pdf"

rule solve:
	input: data="data/simplicity.txt", model="model/osemosys.txt"
	output: "processed_data/results.sol"
	shell:
		"glpsol -d {input.data} -m {input.model} -o {output}"

rule plot:
	input: "processed_data/SelectedResults.csv"
	output: "processed_data/plot.pdf"
	shell:
		"python scripts/plot_results.py {input} {output}"
	
rule clean:
	shell:
		"rm -f processed_data/*.pdf processed_data/*.sol processed_data/*.csv"
	