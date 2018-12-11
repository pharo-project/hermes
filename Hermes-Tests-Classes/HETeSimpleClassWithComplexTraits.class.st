"
Just a class used for tests, it has a complex trait combination.
"
Class {
	#name : #HETeSimpleClassWithComplexTraits,
	#superclass : #HETeSimpleClass,
	#traits : 'THEOneTestTrait - {#oneMessageRequired} + (THEOtherTestTrait @ {#otherMessage2->#otherMessage})',
	#classTraits : 'THEOneTestTrait classTrait + THEOtherTestTrait classTrait',
	#category : #'Hermes-Tests-Classes'
}

{ #category : #'as yet unclassified' }
HETeSimpleClassWithComplexTraits >> externalMethod [
	^ 73
]
