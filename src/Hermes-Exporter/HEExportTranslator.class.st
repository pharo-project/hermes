"
I hold the configuration to translate the encoder classes used in methods.
I translate the name of a given encoder class to the corresponding in the target image.
The encoders (source and target) should use compatible bytecode, as the bytecode is not translated.
"
Class {
	#name : #HEExportTranslator,
	#superclass : #HEBinaryReader,
	#instVars : [
		'encoderTranslateTable'
	],
	#classVars : [
		'Instance'
	],
	#category : #'Hermes-Exporter'
}

{ #category : #'instance creation' }
HEExportTranslator class >> default [
	^ self new.
]

{ #category : #'instance creation' }
HEExportTranslator class >> uniqueInstance [
	^ Instance ifNil: [ Instance := self default ]
]

{ #category : #accessing }
HEExportTranslator >> encoderTranslateTable [
	^ encoderTranslateTable
]

{ #category : #accessing }
HEExportTranslator >> encoderTranslateTable: anObject [
	encoderTranslateTable := anObject
]

{ #category : #initialization }
HEExportTranslator >> initialize [
	encoderTranslateTable := {
	 #OpalEncoderForSistaV1 -> #EncoderForSistaV1.
	 #OpalEncoderForV3 -> #EncoderForV3.
	 #OpalEncoderForV3PlusClosures -> #EncoderForV3PlusClosures
	} asDictionary
]

{ #category : #translate }
HEExportTranslator >> translateEncoderName: aEncoderName [
	^ encoderTranslateTable at: aEncoderName asSymbol ifAbsent: [ aEncoderName ]
]
