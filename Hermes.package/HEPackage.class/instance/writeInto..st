writing
writeInto: aWriter
	aWriter writeInt: version.
	aWriter writeByteString: packageName.
	aWriter writeInt: imageVersion.

	self writeClassesInto: aWriter.
	
	aWriter writeInt: extensionMethods size.
	extensionMethods do:[:e | e writeInto: aWriter].