"
Abstract class that has the common behaviour of the HEInstallerTests
"
Class {
	#name : #HEInstallerTest,
	#superclass : #HEAbstractBinaryClassBuilderTest,
	#instVars : [
		'aClass',
		'aTrait',
		'installer'
	],
	#category : #'Hermes-Tests'
}

{ #category : #utils }
HEInstallerTest >> changeNameOf: exportedClass to: aNewName [
	(exportedClass isKindOf: HETrait)
		ifTrue: [ 
				exportedClass methods do:[:e | self renameExportedClass: exportedClass traitName to: aNewName on:e ].
				exportedClass instVarNamed: #traitName put: aNewName. 
			]
		ifFalse: [ 
			exportedClass methods do:[:e | self renameExportedClass: exportedClass className to: aNewName on:e ].			
			exportedClass instVarNamed: #className put: aNewName ].
		

]

{ #category : #utils }
HEInstallerTest >> renameExportedClass: aName to: aNewName on:aMethod [
	aMethod literals do:[ :e |
		(e isKindOf: HEAdditionalMethodState) ifTrue:[
			e value value do:[:x | 
				(x isKindOf: HEPragma) ifTrue:[
					(x method className = aName) 
						ifTrue: [ x method className: aNewName ]]]]
	].
]

{ #category : #initialization }
HEInstallerTest >> setUp [
	super setUp.
	installer := HEInstaller new.
]

{ #category : #initialization }
HEInstallerTest >> tearDown [

	aClass ifNotNil: [ :class | class removeFromSystem ].
	aTrait ifNotNil: [ :trait | trait removeFromSystem ].

	Undeclared removeKey: #AUndeclared ifAbsent: [  ].

	super tearDown
]
