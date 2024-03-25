// Define the process
process multiqc {
  tag "MERGING FASTQC REPORTS" 
	debug = false
	publishDir "${params.output}", mode: 'copy'

	input:
	path ('*')

	output:
	path ('multiqc_report.html')
	path ('multiqc_data')

	script:
	"""
	multiqc .
	"""
}