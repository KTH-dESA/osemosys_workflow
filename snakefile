RESULTS = ['tid_demand', 'total_annual_capacity']

rule all:
	input: expand("processed_data/{x}.pdf", x=RESULTS)
	message: "Running pipeline to generate the files '{input}'"

rule solve:
	input: data="data/simplicity.txt", model="model/osemosys.txt"
	output: results="processed_data/results.sol", default="processed_data/SelectedResults.csv"
	log: "processed_data/glpsol.log"
	conda: "env/osemosys.yaml"
	shell:
		"glpsol -d {input.data} -m {input.model} -o {output.results} > {log}"

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

rule plot:
	input: "processed_data/{result}.csv"
	output: "processed_data/{result}.pdf"
	message: "Generating plot using '{input}' and writing to '{output}'"
	shell:
		"python scripts/plot_results.py {input} {output}"

rule clean:
	shell:
		"rm -f processed_data/*.pdf processed_data/*.sol processed_data/*.csv *.png"
