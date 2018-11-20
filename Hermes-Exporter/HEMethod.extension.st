Extension { #name : #HEMethod }

{ #category : #'*Hermes-Exporter' }
HEMethod >> fillEncoderClassName: aMethod [
	"When a method is exported the name of the encoder class used is stored with it.
	The name stored is the name of the target class.
	A HEExportTranslator is used to handle the case when the target image has different (but compatible)
	classes to handle the method"
	encoderClassName := HEExportTranslator uniqueInstance
		translateEncoderName: aMethod encoderClass name
]

{ #category : #'*Hermes-Exporter' }
HEMethod >> fillLiteralsAndBytecode: aMethod [
	| literalSpace |
	
	"From a real method the information is extracted.
	All the literals are transformed as exported literals"
	self fillEncoderClassName: aMethod.
	
	numArgs := aMethod numArgs.
	numTemps := aMethod numTemps.
	hasPrimitive := aMethod isPrimitive asBit.

	literalSpace := (aMethod numLiterals + 1) * Smalltalk wordSize.

	bytecode := ByteArray new: aMethod size - literalSpace.
	1 to: bytecode size do: [ :i | bytecode at: i put: (aMethod at: i + literalSpace) ].

	literals := aMethod allLiterals allButLast collect: [ :e | e asExportedLiteral ].
	"The last literal is the binding of the method with the holding class, it is easy to reconstruct"
	literals := literals copyWith: nil asExportedLiteral.
]

{ #category : #'*Hermes-Exporter' }
HEMethod class >> for: aMethod [
	^ self new
		fromMethod: aMethod;
		yourself
]

{ #category : #'*Hermes-Exporter' }
HEMethod >> fromMethod: aMethod [
	name := aMethod selector.
	className := aMethod methodClass name.
	protocol := aMethod protocol.
	self fillLiteralsAndBytecode: aMethod
]

{ #category : #'*Hermes-Exporter' }
HEMethod >> writeInto: aWriter [
	aWriter writeByteString: name.
	aWriter writeByteString: className.
	aWriter writeByteString: protocol.

	aWriter writeByteString: encoderClassName.
	aWriter writeUInt32: numArgs.
	aWriter writeUInt32: numTemps.
	aWriter writeUInt32: hasPrimitive.

	aWriter writeByteArray: bytecode.
	
	aWriter writeInt32: literals size.
	literals do:[:e | e writeInto: aWriter].
]
