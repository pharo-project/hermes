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

{ #category : #'*Hermes-Exporter' }
HECompiledBlock >> value: aCompiledBlock [
	
	| literalSpace |

	value := aCompiledBlock.
	encoderClassName := self encoderClassName: aCompiledBlock.
	
	numArgs := aCompiledBlock numArgs.
	numTemps := aCompiledBlock numTemps.
	hasPrimitive := aCompiledBlock isPrimitive asBit.

	literalSpace := (aCompiledBlock numLiterals + 1) * Smalltalk wordSize.

	bytecode := ByteArray new: aCompiledBlock size - literalSpace.
	1 to: bytecode size do: [ :i | bytecode at: i put: (aCompiledBlock at: i + literalSpace) ].

	literals := aCompiledBlock allLiterals allButLast collect: [ :e | e asExportedLiteral ].
	"The last literal is the home method or block of this compiledBlock"
	literals := literals copyWith: nil asExportedLiteral.
]
