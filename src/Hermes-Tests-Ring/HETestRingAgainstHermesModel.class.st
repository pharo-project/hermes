Class {
	#name : #HETestRingAgainstHermesModel,
	#superclass : #HERingTest,
	#instVars : [
		'hermesPackage'
	],
	#category : #'Hermes-Tests-Ring'
}

{ #category : #accessing }
HETestRingAgainstHermesModel >> behaviorNamed: aName [

	^ hermesPackage classes 
		detect: [ :aClass | aClass className = aName ]
		ifNone: [ hermesPackage traits detect: [ :aTrait | aTrait traitName = aName ] ]
]

{ #category : #comparing }
HETestRingAgainstHermesModel >> compareBehavior: aClass with: aRGClass [

	| aClassTraitComposition rgClassTraitComposition |

	self assert: aClass name equals: aRGClass name.

	"instance side local methods"
	self assertCollection: (aClass methods collect: [ :met | met selector ]) asArray 
			hasSameElements: (aRGClass localMethods collect: [ :met | met selector]).

"	self assertCollection: (aClass methods collect: [ :met | met sourceCode ]) asArray 
			hasSameElements: (aRGClass localMethods collect: [ :met | met sourceCode]).
"
	"class side local methods"
	self assertCollection: (aClass classSideMethods collect: [ :met | met selector ]) asArray 
				hasSameElements: (aRGClass classSide localMethods collect: [ :met | met selector]).

"	self assertCollection: (aClass class methods collect: [ :met | met sourceCode ]) asArray 
				hasSameElements: (aRGClass classSide localMethods collect: [ :met | met sourceCode]). 
"	
	"traits composition"
	aClassTraitComposition := aClass traitComposition.
	rgClassTraitComposition := HETraitCompositionExporter export: aRGClass traitCompositionString.
	
	self assert: aClassTraitComposition equals: rgClassTraitComposition.
	
]

{ #category : #comparing }
HETestRingAgainstHermesModel >> compareClass: hermesClass with: aRGClass [

	self assert: hermesClass className equals: aRGClass name.

	hermesClass superclass isNil 
		ifTrue: [ self assert: aRGClass superclass isNil]
		ifFalse: [self assert: hermesClass superclass equals: aRGClass superclass name].

	"instance variables"
	self assert: hermesClass instanceVariables equals: aRGClass instanceVariablesString.

	"instance class variables"
	self assert: hermesClass classInstancevariables equals: aRGClass metaclass instanceVariablesString.

	"Class Variables"
	self assert: hermesClass classVariables equals: aRGClass classVariablesString.
	self assert: hermesClass sharedPools equals: (aRGClass sharedPoolNames joinUsing: ' ').	

	self compareBehavior: hermesClass with: aRGClass
]

{ #category : #comparing }
HETestRingAgainstHermesModel >> compareTrait: aHermesTrait with: aRGTrait [

	self compareBehavior: aHermesTrait with: aRGTrait
]

{ #category : #'as yet unclassified' }
HETestRingAgainstHermesModel >> setUp [
	
	| ringPackage |
	super setUp.
	self loadPackages: #('Hermes-Tests-Classes').
	
	ringPackage := rgEnvironment ask packageNamed: #'Hermes-Tests-Classes'.
	hermesPackage := HERing2ToHermesBuilder new visitPackage: ringPackage
]
