Class {
	#name : #HERing2ToHermesBuilder,
	#superclass : #Object,
	#category : #'Hermes-Ring2'
}

{ #category : #compiling }
HERing2ToHermesBuilder >> compileMethod: aRGMethod [
	
	^ OpalCompiler new
		class: aRGMethod parent;
		source: aRGMethod sourceCode;
		environment: aRGMethod environment;		
		compile
]

{ #category : #visiting }
HERing2ToHermesBuilder >> visitClass: aClass [
	| aHEClass |
	
	aHEClass := HEClass new.
	self visitMethodContainer: aClass using: aHEClass.

	aHEClass className: aClass name.
	aHEClass superclass: (aClass superclass ifNil: '' ifNotNil:#name).
	aHEClass instanceVariables: ((aClass slots collect: #name) joinUsing: ' ').
	aHEClass classInstancevariables: ((aClass metaclass slots collect: #name) joinUsing: ' ').
	aHEClass classVariables: (aClass classVarNames joinUsing: ' ').
	aHEClass sharedPools: ((aClass sharedPools collect: #name) joinUsing: ' ').
	aHEClass layoutClass: aClass layout layoutName.

	aHEClass category: aClass category.
	aHEClass traitComposition: aClass traitComposition asExportedLiteral.
	aHEClass classTraitComposition: aClass theMetaClass traitComposition asExportedLiteral.


	^ aHEClass.
]

{ #category : #visiting }
HERing2ToHermesBuilder >> visitMethod: aMethod [
	| aHEMethod compiledMethod |
	aHEMethod  := HEMethod new.
	aHEMethod name: aMethod selector.
	aHEMethod className: aMethod methodClass name.
	aHEMethod protocol: aMethod protocol.

	compiledMethod := self compileMethod: aMethod.

	aHEMethod fillLiteralsAndBytecode: compiledMethod.
	
	^ aHEMethod
]

{ #category : #visiting }
HERing2ToHermesBuilder >> visitMethodContainer: aMethodContainer using: aHEClass [
	| instanceMethods classMethods |

	aHEClass category: aMethodContainer category.
	aHEClass traitComposition: aMethodContainer traitComposition asExportedLiteral.
	aHEClass classTraitComposition: aMethodContainer theMetaClass traitComposition asExportedLiteral.

	instanceMethods := aMethodContainer localMethods reject: [:e | e isExtension ].
	classMethods := aMethodContainer theMetaClass localMethods reject: [:e | e isExtension ].

	aHEClass methods: (instanceMethods collect: [ :e | e acceptVisitor: self ]).
	aHEClass classSideMethods: (classMethods collect: [ :e | e acceptVisitor: self])
]

{ #category : #visiting }
HERing2ToHermesBuilder >> visitPackage: aPackage [
	| aHEPackage classDefinedSorted |
	aHEPackage := HEPackage new.

	aHEPackage packageName: aPackage name.

	aHEPackage traits: ((aPackage definedClasses select: #isTrait) collect: [ :e | e acceptVisitor:self ] as: OrderedCollection).

	(aPackage definedClasses reject: #isTrait) do: [ :e | aHEPackage addClass: (e acceptVisitor:self) ].
	aPackage extensionMethods do: [ :e | aHEPackage extensionMethods add: (e acceptVisitor:self) ].
	
	^ aHEPackage.
]

{ #category : #visiting }
HERing2ToHermesBuilder >> visitTrait: aTrait [
	| aHETrait |
	
	aHETrait := HETrait new.
	self visitMethodContainer: aTrait using: aHETrait.

	aHETrait instVarNamed: #traitName put: aTrait name.
	
	^ aHETrait.
]
