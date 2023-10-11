Extension { #name : #HEAbstractExported }

{ #category : #'*Hermes-Exporter' }
HEAbstractExported >> encoderClassName: aMethod [
	"When a method is exported the name of the encoder class used is stored with it.
	The name stored is the name of the target class.
	A HEExportTranslator is used to handle the case when the target image has different (but compatible)
	classes to handle the method"
	^ HEExportTranslator uniqueInstance
		translateEncoderName: aMethod encoderClass name
]
