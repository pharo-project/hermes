Extension { #name : #HETrait }

{ #category : #'*Hermes-Exporter' }
HETrait >> doWriteHeaderInto: aWriter [
	aWriter writeByteString: traitName
]

{ #category : #'*Hermes-Exporter' }
HETrait class >> for: aTrait [
	^ self new
		fromTrait: aTrait;
		yourself
]

{ #category : #'*Hermes-Exporter' }
HETrait >> fromTrait: aTrait [
	traitName := aTrait name.

	self doFromMethodContainer: aTrait
]
