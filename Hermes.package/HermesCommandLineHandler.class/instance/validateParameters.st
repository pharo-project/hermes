validation
validateParameters
	(self commandLine hasFileWithExtension: '.hermes')
		ifFalse: [ ^ self exitFailure: 'Missing Hermes file as argument' ]