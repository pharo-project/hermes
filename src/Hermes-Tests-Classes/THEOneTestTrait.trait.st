"
A simple trait used in tests
"
Trait {
	#name : 'THEOneTestTrait',
	#category : 'Hermes-Tests-Classes-Traits',
	#package : 'Hermes-Tests-Classes',
	#tag : 'Traits'
}

{ #category : 'as yet unclassified' }
THEOneTestTrait classSide >> someClassSideMessage [
	^ self new.
]

{ #category : 'a protocol so useful' }
THEOneTestTrait >> oneMessage [
	^ 1234
]

{ #category : 'a protocol so useful' }
THEOneTestTrait >> oneMessageRequired [
	self shouldBeImplemented
]
