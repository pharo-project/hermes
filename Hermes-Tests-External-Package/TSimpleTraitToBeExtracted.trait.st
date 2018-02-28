"
I am a class used by Hermes to test
"
Trait {
	#name : #TSimpleTraitToBeExtracted,
	#category : #'Hermes-Tests-External-Package'
}

{ #category : #'as yet unclassified' }
TSimpleTraitToBeExtracted >> anObject [
	^ self shouldBeImplemented
]

{ #category : #'as yet unclassified' }
TSimpleTraitToBeExtracted >> doingSomething [
	^ self anObject
]
