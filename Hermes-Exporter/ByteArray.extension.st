Extension { #name : #ByteArray }

{ #category : #'*Hermes-Exporter' }
ByteArray >> asExportedLiteral [
	^ HEByteArray for:self.
]
