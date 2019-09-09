rule all:
	input: "processed_data/plot.pdf"

rule solve:
	input: data="data/simplicity.txt", model="model/osemosys.txt"
	output: results="processed_data/results.sol", default="processed_data/SelectedResults.csv"
	shell:
		"glpsol -d {input.data} -m {input.model} -o {output.results}"

rule plot_total_annual_capacity:
	input: "processed_data/total_annual_capacity.csv"
	output: "processed_data/plot.pdf"
	shell:
		"python scripts/plot_results.py {input} {output}"
	
rule clean:
	shell:
		"rm -f processed_data/*.pdf processed_data/*.sol processed_data/*.csv"

rule extract_tid_demand:
	input: "processed_data/SelectedResults.csv"
	output: "processed_data/tid_demand.csv"
	shell:
		"head -n 33 {input} | tail -n 22 > {output}"

rule extract_total_annual_capacity:
	input: "processed_data/SelectedResults.csv"
	output: "processed_data/total_annual_capacity.csv"
	shell:
		"head -n 326 {input} | tail -n 29 > {output}"