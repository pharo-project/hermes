Class {
	#name : 'HEInstallWholePackageTest',
	#superclass : 'HEAbstractBinaryClassBuilderTest',
	#instVars : [
		'builder',
		'newClass'
	],
	#category : 'Hermes-Tests',
	#package : 'Hermes-Tests'
}

{ #category : 'utilities' }
HEInstallWholePackageTest >> changeClassesNames: aPackage [
	aPackage instVarNamed: #packageName put: #'Hermes-Tests-External-Package2'.
	aPackage classes
		do: [ :e | 
			e instVarNamed: #packageName put: #'Hermes-Tests-External-Package2'.
			e instVarNamed: #className put: (e className , '2') asSymbol.
			self updateMethodLiterals: e methods.
			self updateMethodLiterals: e classSideMethods ].

	aPackage traits
		do: [ :e | 
			e instVarNamed: #packageName put: #'Hermes-Tests-External-Package2'.
			e instVarNamed: #traitName put: (e traitName , '2') asSymbol.
			self updateMethodLiterals: e methods.
			self updateMethodLiterals: e classSideMethods ].

	aPackage extensionMethods
		do: [ :e | 
			e instVarNamed: #name put: (e name , '2') asSymbol.
			e instVarNamed: #protocol put: #'*Hermes-Tests-External-Package2' ].

]

{ #category : 'utilities' }
HEInstallWholePackageTest >> installCopyOfExternalPackage [
	"Export the external test package, rename its classes, traits and extension methods with a 2 suffix in a package Hermes-Tests-External-Package2, and install it."

	| readPackage |
	(HEPackage for: #'Hermes-Tests-External-Package' asPackage) writeInto: writer.
	writer flush.

	readPackage := HEPackage readFrom: reader.
	self changeClassesNames: readPackage.

	builder installPackage: readPackage
]

{ #category : 'initialization' }
HEInstallWholePackageTest >> setUp [
	super setUp.
	builder := HEInstaller new
]

{ #category : 'initialization' }
HEInstallWholePackageTest >> tearDown [

	(#'Hermes-Tests-External-Package2' asPackageIfAbsent: [ nil ]) ifNotNil: [ :package | package removeFromSystem ].
	super tearDown
]

{ #category : 'tests' }
HEInstallWholePackageTest >> testExportingWholePackageAndImportingIt [

	| newPackage oldPackage obj obj2 |
	oldPackage := #'Hermes-Tests-External-Package' asPackage.

	self installCopyOfExternalPackage.
	newPackage := #'Hermes-Tests-External-Package2' asPackage.

	self assert: newPackage classes size equals: oldPackage classes size.

	newClass := Smalltalk at: #AClassToBeExtractedFactory2.
	obj := newClass new.
	obj2 := obj anObject.

	self assert: obj2 class equals: (Smalltalk at: #AClassToBeExtracted2)
]

{ #category : 'tests' }
HEInstallWholePackageTest >> testInstallingAPackageInstallsItsExtensionMethods [

	| extensionMethod |
	self installCopyOfExternalPackage.

	extensionMethod := HETeSimpleClassWithComplexTraits >> #externalMethod2.

	self assert: HETeSimpleClassWithComplexTraits new externalMethod2 equals: 73.
	self assert: extensionMethod package name equals: #'Hermes-Tests-External-Package2' asPackage name
]

{ #category : 'utilities' }
HEInstallWholePackageTest >> updateMethodLiterals: methods [
	methods
		do: [ :e | 
			e instVarNamed: #className put: (e className , '2') asSymbol.
			e literals
				do: [ :lit | 
					(lit isKindOf: HEGlobalVariable)
						ifTrue: [ lit instVarNamed: #value put: (lit value , '2') asSymbol ] ] ]
]
