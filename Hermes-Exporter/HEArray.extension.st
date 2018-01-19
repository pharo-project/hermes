Extension { #name : #HEArray }

{ #category : #'*Hermes-Exporter' }
HEArray >> allDependenciesIn: aCollection [ 

	^ self value flatCollect: [ :aTrait | aTrait allDependenciesIn: aCollection ]
]

{ #category : #'*Hermes-Exporter' }
HEArray >> doWriteInto: aWriter [
	aWriter writeInt32: value size.
	value do:[:e | e writeInto: aWriter].
]
