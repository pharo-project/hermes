Class {
	#name : #HETestRingAgainstSystemClasses,
	#superclass : #HERingTest,
	#category : #'Hermes-Tests-Ring'
}

{ #category : #'as yet unclassified' }
HETestRingAgainstSystemClasses >> behaviorNamed: aName [

	^ self class environment at: aName
]

{ #category : #comparing }
HETestRingAgainstSystemClasses >> compareBehavior: aClass with: aRGClass [

	| aClassTraitComposition rgClassTraitComposition |

	self assert: aClass name equals: aRGClass name.

	"instance variables"
	self assertCollection: aClass instVarNames hasSameElements: aRGClass instVarNames.

	"instance class variables"
	self assertCollection: aClass class instVarNames hasSameElements: aRGClass metaclass instVarNames.

	"instance side local methods"
	self assertCollection: (aClass localMethods collect: [ :met | met selector ]) asArray 
			hasSameElements: (aRGClass localMethods collect: [ :met | met selector]).

	self assertCollection: (aClass localMethods collect: [ :met | met sourceCode ]) asArray 
			hasSameElements: (aRGClass localMethods collect: [ :met | met sourceCode]).

	"class side local methods"
	self assertCollection: (aClass class localMethods collect: [ :met | met selector ]) asArray 
				hasSameElements: (aRGClass classSide localMethods collect: [ :met | met selector]).

	self assertCollection: (aClass class localMethods collect: [ :met | met sourceCode ]) asArray 
				hasSameElements: (aRGClass classSide localMethods collect: [ :met | met sourceCode]). 
	
	"traits composition"
	aClassTraitComposition := HETraitCompositionExporter export: aClass traitCompositionString.
	rgClassTraitComposition := HETraitCompositionExporter export: aRGClass traitCompositionString.
	
	self assert: aClassTraitComposition equals: rgClassTraitComposition.
	
]

{ #category : #comparing }
HETestRingAgainstSystemClasses >> compareClass: aClass with: aRGClass [

	self assert: aClass name equals: aRGClass name.

	aClass superclass isNil 
		ifTrue: [ self assert: aClass superclass equals: aRGClass superclass ]
		ifFalse: [self assert: aClass superclass name equals: aRGClass superclass name].

	"Class Variables"
	self assertCollection: aClass classVariablesString hasSameElements: aRGClass classVariablesString.
	self assertCollection: aClass sharedPoolNames hasSameElements: aRGClass sharedPoolNames.	

	self compareBehavior: aClass with: aRGClass
]

{ #category : #comparing }
HETestRingAgainstSystemClasses >> compareTrait: aTrait with: aRGClass [

	self compareBehavior: aTrait with: aRGClass
]
