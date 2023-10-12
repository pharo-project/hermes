Class {
	#name : #HERingTest,
	#superclass : #TestCase,
	#instVars : [
		'rgEnvironment',
		'packagesNames'
	],
	#category : #'Hermes-Tests-Ring'
}

{ #category : #testing }
HERingTest class >> isAbstract [ 

	^ self name = #HERingTest 
]

{ #category : #'as yet unclassified' }
HERingTest >> compareClass: aClassName [

	self compareClass: (self behaviorNamed: aClassName) with: (rgEnvironment ask classNamed: aClassName)
]

{ #category : #'as yet unclassified' }
HERingTest >> compareTrait: aTraitName [

	self compareTrait: (self behaviorNamed: aTraitName) with: (rgEnvironment ask traitNamed: aTraitName)
]

{ #category : #'as yet unclassified' }
HERingTest >> loadPackages: pNames [
	"initialize new ring environment"
	rgEnvironment := RGEnvironment new.
	packagesNames := pNames.
	packagesNames do: [ :pn |
		| rgPackage snap defs |
		rgPackage := rgEnvironment ensurePackageNamed: pn asSymbol.
		snap := (MCPackage named: pn) snapshot .
		defs := snap definitions.
		defs reversed do: [ :each |
			 each ensureRingDefinitionIn: rgEnvironment package: rgPackage]
		 ].
	rgEnvironment clean.
	rgEnvironment behaviorsDo: [ :beh |
		beh superclass == beh ifTrue: [ beh superclass: nil. ]
		 ].
	^ rgEnvironment 
]

{ #category : #'as yet unclassified' }
HERingTest >> testHETeSimpleClass [
	self compareClass: #HETeSimpleClass
]

{ #category : #'as yet unclassified' }
HERingTest >> testHETeSimpleClassReferingClass [
	self compareClass: #HETeSimpleClassReferingClass
]

{ #category : #'as yet unclassified' }
HERingTest >> testHETeSimpleClassWithComplexTraits [
	self compareClass: #HETeSimpleClassWithComplexTraits
]

{ #category : #'as yet unclassified' }
HERingTest >> testHETeSimpleClassWithNilSuperclass [
	self compareClass: #HETeSimpleClassWithNilSuperclass
]

{ #category : #'as yet unclassified' }
HERingTest >> testHETeSimpleClassWithTraits [
	self compareClass: #HETeSimpleClassWithTraits
]

{ #category : #'as yet unclassified' }
HERingTest >> testTHEATraitUsingOthers [

	self compareTrait: #THEATraitUsingOthers
]

{ #category : #'as yet unclassified' }
HERingTest >> testTHEOneTestTrait [

	self compareTrait: #THEOneTestTrait
]

{ #category : #'as yet unclassified' }
HERingTest >> testTHEOtherTestTrait [
	self compareTrait: #THEOtherTestTrait
]
