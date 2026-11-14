Class {
	#name : 'HEInstallerSimpleTest',
	#superclass : 'HEInstallerTest',
	#category : 'Hermes-Tests-Installing',
	#package : 'Hermes-Tests',
	#tag : 'Installing'
}

{ #category : 'utilities' }
HEInstallerSimpleTest >> assertInstallingKeepsTheLayoutOf: aFixtureClass [

	| exportedClass |
	exportedClass := HEClass for: aFixtureClass.
	self changeNameOf: exportedClass to: (aFixtureClass name , 'New') asSymbol.

	aClass := installer build: exportedClass.

	self assert: aClass classLayout class identicalTo: aFixtureClass classLayout class
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testCreatingAClassInATag [

	| exportedClass |
	exportedClass := HEClass for: HETeTaggedClass.
	self changeNameOf: exportedClass to: #HETeTaggedClassNew.

	aClass := installer build: exportedClass.

	self assert: exportedClass tagName asString equals: 'Tagged'.
	self assert: aClass package name equals: HETeTaggedClass package name.
	self assert: (HEClass for: aClass) tagName equals: exportedClass tagName
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testCreatingAClassUsingASharedPool [

	| exportedClass |
	exportedClass := HEClass for: HETeSimpleClassUsingSharedPool.
	self changeNameOf: exportedClass to: #HETeSimpleClassUsingSharedPoolNew.

	aClass := installer build: exportedClass.
	installer installMethods: exportedClass into: aClass.

	self assert: aClass sharedPools asArray equals: { HETeSharedPool }.
	self assert: aClass new sharedValue equals: 42
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testCreatingAClassUsingComplexTraits [
	| exportedClass obj|
	
	exportedClass := HEClass for: HETeSimpleClassWithComplexTraits. 
	self changeNameOf: exportedClass to: #HETeSimpleClassWithComplexTraitsNew.
	
	aClass := installer build: exportedClass.
	
	self assert: aClass name equals: #HETeSimpleClassWithComplexTraitsNew.
	self assert: aClass class name equals: #'HETeSimpleClassWithComplexTraitsNew class'.

	installer installMethods: exportedClass into: aClass.

	self deny: aClass traitComposition isEmpty.
	self deny: aClass class traitComposition isEmpty.
		
	obj := aClass new.
	
	self assert: obj oneMessage equals: 1234.
	self assert: obj otherMessage equals: 4321.	
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testCreatingAClassUsingTraits [
	| exportedClass obj|
	
	exportedClass := HEClass for: HETeSimpleClassWithTraits. 
	self changeNameOf: exportedClass to: #HETeSimpleClassWithTraitsNew.
	
	aClass := installer build: exportedClass.
	
	self assert: aClass name equals: #HETeSimpleClassWithTraitsNew.
	self assert: aClass class name equals: #'HETeSimpleClassWithTraitsNew class'.

	installer installMethods: exportedClass into: aClass.

	self deny: aClass traitComposition isEmpty.
	self deny: aClass class traitComposition isEmpty.
		
	obj := aClass someClassSideMessage.

	self assert: aClass slots isEmpty.	
	self assert: aClass class slots isEmpty.	

	self assert: obj oneMessage equals: 1234.
	self assert: obj otherMessage equals: 4321.	
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testCreatingAClassWithAByteLayout [

	self assertInstallingKeepsTheLayoutOf: HETeByteClass
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testCreatingAClassWithAVariableLayout [

	self assertInstallingKeepsTheLayoutOf: HETeVariableClass
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testCreatingAClassWithAWeakLayout [

	self assertInstallingKeepsTheLayoutOf: HETeWeakClass
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testCreatingAClassWithUndeclared [
	| exportedClass |
	
	exportedClass := HEClass for: HETeSimpleClassReferingClass. 
	self changeNameOf: exportedClass to: #HETeSimpleClassReferingUndeclaredNew.
	
	((exportedClass methods at: 1) literals at:1) instVarNamed: #value put: #AUndeclared.
	
	aClass := installer build: exportedClass.
	
	installer installMethods: exportedClass into: aClass.

	self assert: installer createdUndeclared size equals: 1.

	self should: [installer validateNoNewUndeclared] raise: Error.
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testCreatingAClassWithUndeclaredWithNoFailOption [
	| exportedClass |
	
	installer := HEExtendedInstaller new.
	installer failOnUndeclared: false.
	
	exportedClass := HEClass for: HETeSimpleClassReferingClass. 
	self changeNameOf: exportedClass to: #HETeSimpleClassReferingUndeclaredNew.
	
	((exportedClass methods at: 1) literals at:1) instVarNamed: #value put: #AUndeclared.
	
	aClass := installer build: exportedClass.
	
	installer installMethods: exportedClass into: aClass.

	self assert: installer createdUndeclared size equals: 1.

	installer validateNoNewUndeclared
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testCreatingASimpleClass [
	| exportedClass slots classSlots obj |
	
	exportedClass := HEClass for: HETeSimpleClass. 
	self changeNameOf: exportedClass to: #HETeSimpleClassNew.
	
	aClass := installer build: exportedClass.
	
	self assert: aClass name equals: #HETeSimpleClassNew.
	self assert: aClass class name equals: #'HETeSimpleClassNew class'.
	
	slots :=  {#anInstanceVariable => InstanceVariableSlot}.
	(slots at:1) index: 1.	
	self assert: aClass slots equals: slots.
	
	classSlots :=  {#aClassInstanceVariable => InstanceVariableSlot}.
	(classSlots at:1) index: (Object class allSlots size + 1).		
	self assert: aClass class slots equals: classSlots.
	
	self assert: aClass traitComposition isEmpty.
	self assert: aClass classVariables equals: { #AClassVariable => ClassVariable }.
	
	installer installMethods: exportedClass into: aClass.

	self assert: aClass traitComposition isEmpty.
	self assert: aClass class traitComposition isEmpty.

	obj := aClass newInstance.
	
	obj anInstanceVariable: 25.
	self assert: obj anInstanceVariable equals: 25.
	self assert: obj otherMethod equals: 25.
	self assert: obj usingAConstant equals: 42.
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testCreatingASimpleClassExportingToFile [
	| exportedClass obj readedClass |
	
	exportedClass := HEClass for: HETeSimpleClass. 
	self changeNameOf: exportedClass to: #HETeSimpleClassNew.

	exportedClass writeInto: writer.
	writer flush.
	
	readedClass := HEClass readFrom: reader.

	self assert: readedClass equals: exportedClass.
	
	aClass := installer build: exportedClass.	
	installer installMethods: exportedClass into: aClass.

	self assert: aClass traitComposition isEmpty.
	self assert: aClass class traitComposition isEmpty.

	obj := aClass newInstance.
	
	obj anInstanceVariable: 25.
	self assert: obj anInstanceVariable equals: 25.
	self assert: obj otherMethod equals: 25.
	self assert: obj usingAConstant equals: 42.
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testCreatingASimpleTrait [

	| exportedTrait |
	exportedTrait := HETrait for: THEOneTestTrait.
	self changeNameOf: exportedTrait to: #THEOneTestTraitNew.

	aTrait := installer buildTrait: exportedTrait.
	installer installMethods: exportedTrait into: aTrait.

	self assert: aTrait traitComposition isEmpty.
	self assert: aTrait classSide traitCompositionString equals: '{}'.
	self assert: aTrait methods size equals: THEOneTestTrait methods size.

	self assert: aTrait classTrait methods size equals: THEOneTestTrait classTrait methods size.

	aTrait >> #oneMessage.
	aTrait >> #oneMessageRequired
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testCreatingATraitUsingOthers [
	| exportedTrait |
	exportedTrait := HETrait for: THEATraitUsingOthers.
	self changeNameOf: exportedTrait to: #THEATraitUsingOthersNew.
	aTrait := installer buildTrait: exportedTrait.
	installer installMethods: exportedTrait into: aTrait.
	self deny: aTrait traitComposition isEmpty.
	self deny: aTrait classSide traitComposition isEmpty.
	self
		assert: aTrait methods size
		equals: THEATraitUsingOthers methods size.
	self
		assert: aTrait classTrait methods size
		equals: THEATraitUsingOthers classTrait methods size.
	self
		assert: aTrait traitComposition printString
		equals: THEATraitUsingOthers traitComposition printString.
	self
		assert: aTrait classTrait traitComposition printString
		equals: THEATraitUsingOthers classTrait traitComposition printString.
	aTrait >> #oneMessage.
	aTrait >> #oneMessageRequired
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testCreatingAWithNilSuperclass [
	| exportedClass slots classSlots |
	
	exportedClass := HEClass for: HETeSimpleClassWithNilSuperclass. 
	self changeNameOf: exportedClass to: #HETeSimpleClassWithNilSuperclassNew.
	
	aClass := installer build: exportedClass.
	
	self assert: aClass name equals: #HETeSimpleClassWithNilSuperclassNew.
	self assert: aClass class name equals: #'HETeSimpleClassWithNilSuperclassNew class'.
	
	slots :=  {#anInstanceVariable => InstanceVariableSlot}.
	(slots at:1) index: 1.	
	self assert: aClass slots equals: slots.
	
	classSlots :=  #().
	self assert: aClass class slots equals: classSlots.
	
	self assert: aClass traitComposition isEmpty.
	self assert: aClass classVariables equals: { #AClassVariable => ClassVariable }.
	
	installer installMethods: exportedClass into: aClass.

	self assert: aClass traitComposition isEmpty.
	self assert: aClass class traitComposition isEmpty.

	self assert: aClass superclass equals: nil
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testInstalledMethodsKeepTheirProtocol [

	| exportedClass |
	exportedClass := HEClass for: HETeSimpleClass.
	self changeNameOf: exportedClass to: #HETeSimpleClassNew.

	aClass := installer build: exportedClass.
	installer installMethods: exportedClass into: aClass.

	"The fixture uses several protocols, so a method installed in a default protocol would be noticed."
	self assert: (exportedClass methods collect: [ :method | method protocol ]) asSet size > 1.
	exportedClass methods do: [ :exportedMethod | self assert: (HEMethod for: aClass >> exportedMethod name) protocol equals: exportedMethod protocol ].
	exportedClass classSideMethods do: [ :exportedMethod | self assert: (HEMethod for: aClass class >> exportedMethod name) protocol equals: exportedMethod protocol ]
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testPragmaMethod [
	| exportedClass aMethod |
	
	exportedClass := HEClass for: HETeSimpleClass. 
	self changeNameOf: exportedClass to: #HETeSimpleClass2.
	
	aClass := installer build: exportedClass.
	installer installMethods: exportedClass into: aClass.
	
	aMethod := aClass >> #pragmaMethod.
	self assert: aMethod pragmas first method == aMethod. 
]

{ #category : 'tests' }
HEInstallerSimpleTest >> testUndeclared [

	| exportedClass |
	"If we run the test multiple times we need to do this to be sure #AnUndeclaredClass is not in the Undeclared dictionary anymore."
	Smalltalk image cleanOutUndeclared.
	[
		self flag: #pharo11. "Since Pharo 12, the compiler can be asked to permit undeclared variables, and it refuses them by default since Pharo 14. Remove this condition when Pharo 12 is the minimal version."
		SystemVersion current major >= 12
			ifTrue: [
					UndefinedObject compiler
						permitUndeclared: true;
						source: 'xxx
		^ AnUndeclaredClass';
						protocol: #accessing;
						install ]
			ifFalse: [
					UndefinedObject compile: 'xxx
		^ AnUndeclaredClass' ].
		self flag: #pahro11. "In Pharo 12 we should use UndeclaredVariableRead instead of the Error"
		self assert: ([ nil xxx ] on: Error do: [ :e | e resume ]) equals: nil.

		exportedClass := HEClass for: HETeSimpleClass.
		self changeNameOf: exportedClass to: #AnUndeclaredClass.

		aClass := installer build: exportedClass.
		installer installMethods: exportedClass into: aClass.

		self should: [ Undeclared at: #AnUndeclaredClass ] raise: KeyNotFound.
		Smalltalk at: #AnUndeclaredClass ifAbsent: [ self fail: 'Class should be here.' ] ] ensure: [
			UndefinedObject removeSelector: #xxx.
			Smalltalk at: #AnUndeclaredClass ifPresent: [ :class | class removeFromSystem ] ]
]
