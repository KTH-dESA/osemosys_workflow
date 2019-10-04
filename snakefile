rule all:
	input: "processed_data/SelectedResults.csv"
	message: "Running pipeline to generate the files '{input}'"

rule solve:
	input: data="data/simplicity.txt", model="model/osemosys.txt"
	output: results="processed_data/results.sol", default="processed_data/SelectedResults.csv"
	log: "processed_data/glpsol.log"
	conda: "env/osemosys.yaml"
	shell:
		"glpsol -d {input.data} -m {input.model} -o {output.results} > {log}"

rule clean:
	shell:
		"rm -f processed_data/*.sol processed_data/*.csv"
