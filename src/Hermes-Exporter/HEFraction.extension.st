Extension { #name : 'HEFraction' }

{ #category : '*Hermes-Exporter' }
HEFraction >> doWriteInto: aWriter [
	value numerator asExportedLiteral writeInto: aWriter.
	value denominator asExportedLiteral writeInto: aWriter.	
]
