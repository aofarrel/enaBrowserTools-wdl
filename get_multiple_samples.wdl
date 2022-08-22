version 1.0

import "./tasks/enaDataGet.wdl"

workflow GetMultipleSamples {
	input {
		Array[String] samples
	}

	scatter(sample in samples) {
		call enaDataGet.enaDataGet {
			input:
				sample = sample
		}
	}

	output {
		Array[Array[File]] fastqs = enaDataGet.fastqs
	}
}