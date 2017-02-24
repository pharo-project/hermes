initialization
setUp
	super setUp.
	filename := (FileReference newTempFilePrefix: 'export' suffix: '.exp') fullName.

	writer := HEBinaryReaderWriter new
		stream: (File openForWriteFileNamed:filename);
		yourself.

	reader := HEBinaryReaderWriter new
		stream: (File openForReadFileNamed:filename);
		yourself.
