Extension { #name : #WideString }

{ #category : #'*Hermes-Exporter' }
WideString >> asExportedLiteral [
	^ HEWideString for:self.
]
