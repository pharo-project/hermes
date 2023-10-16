Class {
	#name : 'HEInstallerDuplicationTest',
	#superclass : 'HEInstallerTest',
	#category : 'Hermes-Tests',
	#package : 'Hermes-Tests'
}

{ #category : 'tests' }
HEInstallerDuplicationTest >> testCreatingADuplicatedMethodsInSimpleClass [
	| exportedClass  |
	
	exportedClass := HEClass for: HETeSimpleClass. 
	self changeNameOf: exportedClass to: #HETeSimpleClassNew.
	
	aClass := installer build: exportedClass.	
	installer installMethods: exportedClass into: aClass.

	self should: [installer installMethods: exportedClass into: aClass.] raise: Error.

]

{ #category : 'tests-extended-installer' }
HEInstallerDuplicationTest >> testCreatingADuplicatedMethodsInSimpleClassFailing [
	| exportedClass method |
	installer := HEExtendedInstaller new.
	
	exportedClass := HEClass for: HETeSimpleClass. 
	self changeNameOf: exportedClass to: #HETeSimpleClassNew.
	
	aClass := installer build: exportedClass.	
	installer installMethods: exportedClass into: aClass.

	method := exportedClass methods detect:[:m | m name = #answer].
	(method literals at: 1) value: 22.

	self should: [installer installMethods: exportedClass into: aClass.] raise: Error.

]

{ #category : 'tests-extended-installer' }
HEInstallerDuplicationTest >> testCreatingADuplicatedMethodsInSimpleClassIgnore [
	| exportedClass method |
	installer := HEExtendedInstaller new.
	installer duplicationMode: HEIgnoreOnDuplication new.
	
	exportedClass := HEClass for: HETeSimpleClass. 
	self changeNameOf: exportedClass to: #HETeSimpleClassNew.
	
	aClass := installer build: exportedClass.	
	installer installMethods: exportedClass into: aClass.

	method := exportedClass methods detect:[:m | m name = #answer].
	(method literals at: 1) value: 22.

	installer installMethods: exportedClass into: aClass.
	
	self assert: aClass new answer equals: 42.

]

{ #category : 'tests-extended-installer' }
HEInstallerDuplicationTest >> testCreatingADuplicatedMethodsInSimpleClassReplace [
	| exportedClass method |
	installer := HEExtendedInstaller new.
	installer duplicationMode: HEReplaceOnDuplication new.
	
	exportedClass := HEClass for: HETeSimpleClass. 
	self changeNameOf: exportedClass to: #HETeSimpleClassNew.
	
	aClass := installer build: exportedClass.	
	installer installMethods: exportedClass into: aClass.

	method := exportedClass methods detect:[:m | m name = #answer].
	(method literals at: 1) value: 22.

	installer installMethods: exportedClass into: aClass.
	
	self assert: aClass new answer equals: 22.

]

{ #category : 'tests' }
HEInstallerDuplicationTest >> testCreatingADuplicatedMethodsInSimpleTrait [
	| exportedTrait |
	
	exportedTrait := HETrait for: THEOneTestTrait. 
	self changeNameOf: exportedTrait to: #THEOneTestTraitNew.
	
	aTrait := installer buildTrait: exportedTrait.	
	installer installMethods: exportedTrait into: aTrait.
	
	self should: [installer installMethods: exportedTrait into: aTrait] raise: Error.	

]

{ #category : 'tests-extended-installer' }
HEInstallerDuplicationTest >> testCreatingADuplicatedMethodsInSimpleTraitFailing [
	| exportedTrait method |
	installer := HEExtendedInstaller new.
	
	exportedTrait := HETrait for: THEOneTestTrait. 
	self changeNameOf: exportedTrait to: #THEOneTestTraitNew.
	
	aTrait := installer buildTrait: exportedTrait.	
	installer installMethods: exportedTrait into: aTrait.	

	method := exportedTrait methods detect:[:m | m name = #oneMessage].
	(method literals at: 1) value: 22.

	self should: [installer installMethods: exportedTrait into: aTrait] raise: Error.	

]

{ #category : 'tests-extended-installer' }
HEInstallerDuplicationTest >> testCreatingADuplicatedMethodsInSimpleTraitIgnore [
	| exportedTrait method |
	installer := HEExtendedInstaller new.
	installer duplicationMode: HEIgnoreOnDuplication new.	
	
	exportedTrait := HETrait for: THEOneTestTrait. 
	self changeNameOf: exportedTrait to: #THEOneTestTraitNew.
	
	aTrait := installer buildTrait: exportedTrait.	
	installer installMethods: exportedTrait into: aTrait.	

	method := exportedTrait methods detect:[:m | m name = #oneMessage].
	(method literals at: 1) value: 22.

	installer installMethods: exportedTrait into: aTrait.	

	self assert: (aTrait >> #oneMessage) literals first equals: 1234
]

{ #category : 'tests-extended-installer' }
HEInstallerDuplicationTest >> testCreatingADuplicatedMethodsInSimpleTraitReplace [
	| exportedTrait method |
	installer := HEExtendedInstaller new.
	installer duplicationMode: HEReplaceOnDuplication new.	
	
	exportedTrait := HETrait for: THEOneTestTrait. 
	self changeNameOf: exportedTrait to: #THEOneTestTraitNew.
	
	aTrait := installer buildTrait: exportedTrait.	
	installer installMethods: exportedTrait into: aTrait.	

	method := exportedTrait methods detect:[:m | m name = #oneMessage].
	(method literals at: 1) value: 22.

	installer installMethods: exportedTrait into: aTrait.	

	self assert: (aTrait >> #oneMessage) literals first equals: 22
]

{ #category : 'tests' }
HEInstallerDuplicationTest >> testCreatingADuplicatedSimpleClass [
	| exportedClass  |
	
	exportedClass := HEClass for: HETeSimpleClass. 
	self changeNameOf: exportedClass to: #HETeSimpleClassNew.
	
	aClass := installer build: exportedClass.	
	installer installMethods: exportedClass into: aClass.

	self should: [installer build:exportedClass] raise: Error.

]

{ #category : 'tests-extended-installer' }
HEInstallerDuplicationTest >> testCreatingADuplicatedSimpleClassFailing [
	| exportedClass  |
	installer := HEExtendedInstaller new.
	
	exportedClass := HEClass for: HETeSimpleClass. 
	self changeNameOf: exportedClass to: #HETeSimpleClassNew.
	
	aClass := installer build: exportedClass.	
	installer installMethods: exportedClass into: aClass.

	exportedClass instanceVariables: 'anInstanceVariable anotherInstanceVariable'.

	self should: [installer build:exportedClass] raise: Error.
]

{ #category : 'tests-extended-installer' }
HEInstallerDuplicationTest >> testCreatingADuplicatedSimpleClassIgnore [
	| exportedClass |
	installer := HEExtendedInstaller new.
	installer duplicationMode: HEIgnoreOnDuplication new.
	exportedClass := HEClass for: HETeSimpleClass.
	self changeNameOf: exportedClass to: #HETeSimpleClassNew.
	aClass := installer build: exportedClass.
	installer installMethods: exportedClass into: aClass.
	exportedClass
		instanceVariables: 'anInstanceVariable anotherInstanceVariable'.
	aClass := installer build: exportedClass.
	self assert: aClass instVarNames equals: #(anInstanceVariable)
]

{ #category : 'tests-extended-installer' }
HEInstallerDuplicationTest >> testCreatingADuplicatedSimpleClassReplace [
	| exportedClass |
	installer := HEExtendedInstaller new.
	installer duplicationMode: HEReplaceOnDuplication new.
	exportedClass := HEClass for: HETeSimpleClass.
	self changeNameOf: exportedClass to: #HETeSimpleClassNew.
	aClass := installer build: exportedClass.
	installer installMethods: exportedClass into: aClass.
	exportedClass
		instanceVariables: 'anInstanceVariable anotherInstanceVariable'.
	aClass := installer build: exportedClass.
	self
		assert: aClass instVarNames
		equals: #(anInstanceVariable anotherInstanceVariable)
]

{ #category : 'tests' }
HEInstallerDuplicationTest >> testCreatingADuplicatedSimpleTrait [
	| exportedTrait |
	
	exportedTrait := HETrait for: THEOneTestTrait. 
	self changeNameOf: exportedTrait to: #THEOneTestTraitNew.
	
	aTrait := installer buildTrait: exportedTrait.	
	installer installMethods: exportedTrait into: aTrait.
	
	self should: [installer buildTrait: exportedTrait] raise: Error.	

]

{ #category : 'tests-extended-installer' }
HEInstallerDuplicationTest >> testCreatingADuplicatedSimpleTraitFailing [
	| exportedTrait |
	installer := HEExtendedInstaller new.
	
	exportedTrait := HETrait for: THEOneTestTrait. 
	self changeNameOf: exportedTrait to: #THEOneTestTraitNew.
	
	aTrait := installer buildTrait: exportedTrait.	
	installer installMethods: exportedTrait into: aTrait.
	
	self should: [installer buildTrait: exportedTrait] raise: Error.	

]

{ #category : 'tests-extended-installer' }
HEInstallerDuplicationTest >> testCreatingADuplicatedSimpleTraitIgnore [

	| exportedTrait |
	installer := HEExtendedInstaller new.
	installer duplicationMode: HEIgnoreOnDuplication new.

	exportedTrait := HETrait for: THEOneTestTrait.
	self changeNameOf: exportedTrait to: #THEOneTestTraitNew.

	aTrait := installer buildTrait: exportedTrait.
	installer installMethods: exportedTrait into: aTrait.

	exportedTrait packageName: (exportedTrait packageName , 'New') asSymbol.
	installer buildTrait: exportedTrait.

	self assert: (Smalltalk at: #THEOneTestTraitNew) package name equals: THEOneTestTrait package name
]

{ #category : 'tests-extended-installer' }
HEInstallerDuplicationTest >> testCreatingADuplicatedSimpleTraitReplace [

	| exportedTrait newPackage |
	installer := HEExtendedInstaller new.
	installer duplicationMode: HEReplaceOnDuplication new.

	exportedTrait := HETrait for: THEOneTestTrait.
	self changeNameOf: exportedTrait to: #THEOneTestTraitNew.

	aTrait := installer buildTrait: exportedTrait.
	installer installMethods: exportedTrait into: aTrait.

	newPackage := (exportedTrait packageName , 'New') asSymbol.
	exportedTrait packageName: newPackage.
	[
	self flag: #pharo11. "This is a hack caused by the package/tag/category mess that should be fixed in P12 release."
	self flag: #pahro11. "Update this when Pharo 12 will be the minimal version"
	SystemVersion current major < 12
		ifTrue: [ RPackageOrganizer default registerPackageNamed: newPackage ]
		ifFalse: [ self packageOrganizer ensurePackage: newPackage ].
	installer buildTrait: exportedTrait.

	self assert: (Smalltalk at: #THEOneTestTraitNew) package name equals: newPackage ] ensure: [
		(newPackage asPackageIfAbsent: [ nil ]) ifNotNil: [ :package | package removeFromSystem ] ]
]
