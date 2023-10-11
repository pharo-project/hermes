Extension { #name : #Fraction }

{ #category : #'*Hermes-Exporter' }
Fraction >> asExportedLiteral [
	^ HEFraction for: self.
]
