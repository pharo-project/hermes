Extension { #name : 'ScaledDecimal' }

{ #category : '*Hermes-Exporter' }
ScaledDecimal >> asExportedLiteral [
	^ HEScaledDecimal for: self.
]
