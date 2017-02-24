tests
testExportingObject
	| old new nonExtensionMethods nonExtensionMethodsClassSide|
	old := HEClass for: Object.
	
	nonExtensionMethods := (Object methods reject:#isExtension) size.
	nonExtensionMethodsClassSide := (Object class methods reject:#isExtension) size.
	
	self assert: old methods size equals: nonExtensionMethods.
	self assert: old classSideMethods size equals: nonExtensionMethodsClassSide.

	old writeInto: writer.

	new := HEClass readFrom: reader.
	self assert: old equals: new.