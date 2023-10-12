Extension { #name : 'HEMethodLiteral' }

{ #category : '*Hermes-Exporter' }
HEMethodLiteral >> doWriteInto: aWriter [
	aWriter writeByteString: className.
	aWriter writeByteString: selector.


]
