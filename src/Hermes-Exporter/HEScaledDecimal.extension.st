Extension { #name : #HEScaledDecimal }

{ #category : #'*Hermes-Exporter' }
HEScaledDecimal >> doWriteInto: aWriter [
	super doWriteInto: aWriter.
	value scale asExportedLiteral writeInto: aWriter.	
]
