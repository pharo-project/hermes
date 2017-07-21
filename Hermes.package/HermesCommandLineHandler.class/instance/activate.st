activation
activate
	| file reader readPackage installer |
	self activateHelp
		ifTrue: [ ^ self ].

	self arguments size = 1
		ifFalse: [ ^ self exitFailure: 'Missing Hermes file as argument' ].

	file := File named: (self arguments at: 1).


	reader := HEBinaryReaderWriter new
		stream: file readStream;
		yourself.

	readPackage := HEPackage readFrom: reader.
	installer := HEInstaller new.
	installer installPackage: readPackage