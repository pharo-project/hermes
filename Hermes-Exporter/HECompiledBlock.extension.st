Extension { #name : #HECompiledBlock }

{ #category : #'*Hermes-Exporter' }
HECompiledBlock >> doWriteInto: aWriter [
	
	aWriter writeByteString: encoderClassName.
	aWriter writeUInt32: numArgs.
	aWriter writeUInt32: numTemps.
	aWriter writeUInt32: hasPrimitive.

	aWriter writeByteArray: bytecode.
	
	aWriter writeInt32: literals size.
	literals do:[:e | e writeInto: aWriter].
]
