"
I represent an Integer.
I am stored as:
   - sign (1 for negative, 0 for possitive)
   - a byte array of the content.

This allows to serialize any given Integer in the image
"
Class {
	#name : 'HEInteger',
	#superclass : 'HEExportedLiteral',
	#category : 'Hermes-Model',
	#package : 'Hermes',
	#tag : 'Model'
}

{ #category : 'accessing' }
HEInteger class >> tag [
	^ 8
]

{ #category : 'converting' }
HEInteger >> asLiteralIn: env [
	^ value
]

{ #category : 'reading' }
HEInteger >> doReadFrom: aReader [
	| anArray isNegative |
	isNegative := aReader readByte = 1.
	anArray := aReader readByteArray.

	value := anArray asInteger * (isNegative ifTrue: [-1] ifFalse: [1])
]
