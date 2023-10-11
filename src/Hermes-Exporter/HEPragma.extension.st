Extension { #name : 'HEPragma' }

{ #category : '*Hermes-Exporter' }
HEPragma >> doWriteInto: aWriter [
	method writeInto: aWriter.
	keyword writeInto: aWriter.
	arguments writeInto: aWriter
]
