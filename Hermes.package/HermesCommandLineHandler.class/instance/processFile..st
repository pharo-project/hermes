processing files
processFile: file
	| installer reader readPackage |
	installer := HEInstaller new.
	
	('[Hermes] Reading ' , file) logCr.
	
	reader := HEBinaryReaderWriter new
		stream: (File named: file) readStream;
		yourself.
	
	readPackage := HEPackage readFrom: reader.
	
	('[Hermes] Installing ' , file) logCr.
	
	installer installPackage: readPackage