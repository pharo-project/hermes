Extension { #name : 'HEArray' }

{ #category : '*Hermes-Exporter' }
HEArray >> allDependenciesIn: aCollection [ 
	"I check that all the traits in myself are included in the collection passed as parameters.
	This is used to check if the trait composition can be correctly serialized. 
	The traits should be serialized before its users, if not they cannot be deserialized"
	^ self value flatCollect: [ :aTrait | aTrait allDependenciesIn: aCollection ]
]

{ #category : '*Hermes-Exporter' }
HEArray >> doWriteInto: aWriter [
	aWriter writeInt32: value size.
	value do:[:e | e writeInto: aWriter].
]
