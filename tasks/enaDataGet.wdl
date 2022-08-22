version 1.0

task enaDataGet {
	input {
		String sample

		# runtime attributes
		Int disk = 100
		Int cpu = 4
		Int retries = 1
		Int memory = 8
		Int preempt = 2
	}

	command <<<
	enaDataGet ~{sample}
	ls -lhaR > workdir.txt
	>>>

	runtime {
		cpu: cpu
		docker: "ashedpotatoes/iqbal-unofficial-clockwork-mirror:latest"
		disks: "local-disk " + disk + " HDD"
		maxRetries: "${retries}"
		memory: "${memory} GB"
		preemptibles: "${preempt}"
	}

	output {
		Array[File] fastqs = glob("~{sample}/*.fastq.gz")
		String sample_out = sample
		File workdir = "workdir.txt"
	}
}