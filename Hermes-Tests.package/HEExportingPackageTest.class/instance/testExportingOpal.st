tests
testExportingOpal
	| old new aPackage |
	aPackage := RPackageOrganizer default packageNamed: 'OpalCompiler-Core'.
	old := HEPackage for:aPackage.
 
	old writeInto: writer.
	new := HEPackage readFrom: reader.
	
	self assert: old classes size equals: (aPackage classes reject:#isTrait) size.
	self assert: old extensionMethods size equals: (aPackage extensionMethods) size.

	self assert: new equals: old.