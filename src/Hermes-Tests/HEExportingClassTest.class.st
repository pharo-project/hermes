Class {
	#name : 'HEExportingClassTest',
	#superclass : 'HEAbstractBinaryClassBuilderTest',
	#category : 'Hermes-Tests',
	#package : 'Hermes-Tests'
}

{ #category : 'tests' }
HEExportingClassTest >> doTestExportingClass: classUnderTest [
	| new old nonExtensionMethodsClassSide nonExtensionMethods |
	old := HEClass for: classUnderTest.

	nonExtensionMethods := (classUnderTest localMethods reject: #isExtension)
		size.
	nonExtensionMethodsClassSide := (classUnderTest class localMethods
		reject: #isExtension) size.

	self assert: old methods size equals: nonExtensionMethods.
	self
		assert: old classSideMethods size
		equals: nonExtensionMethodsClassSide.

	old writeInto: writer.
	writer flush.

	new := HEClass readFrom: reader.
	self assert: old equals: new
]

{ #category : 'tests' }
HEExportingClassTest >> testExportingClassWithBlocks [
	self doTestExportingClass: HETeSimpleClassWithBlocks 
]

{ #category : 'tests' }
HEExportingClassTest >> testExportingClassWithComplexTraits [
	self doTestExportingClass: HETeSimpleClassWithComplexTraits
]

{ #category : 'tests' }
HEExportingClassTest >> testExportingClassWithTraits [
	self doTestExportingClass: HETeSimpleClassWithTraits
]

{ #category : 'tests' }
HEExportingClassTest >> testExportingObject [
	self doTestExportingClass: Object
]
