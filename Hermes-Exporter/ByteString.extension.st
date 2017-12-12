Extension { #name : #ByteString }

{ #category : #'*Hermes-Exporter' }
ByteString >> asExportedLiteral [
	^ HEByteString for:self.
]
