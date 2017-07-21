activation
activate
	| reader readPackage installer |
	self activateHelp
		ifTrue: [ ^ self ].

	(self arguments hasFileWithExtension: '.hermes')
		ifFalse: [ ^ self exitFailure: 'Missing Hermes file as argument' ].

	installer := HEInstaller new.

	(self arguments allFilesWithExtension: '.hermes') do:[ :file |
		reader := HEBinaryReaderWriter new
			stream: file readStream;
			yourself.

		readPackage := HEPackage readFrom: reader.
		installer installPackage: readPackage
	].
	
	(self hasOption: 'save') ifTrue:[
		Smalltalk snapshot: true andQuit: false 
	].
	
	self exitSuccess.