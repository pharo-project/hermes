Class {
	#name : #HEAbstractStampConnected,
	#superclass : #Object,
	#instVars : [
		'connection'
	],
	#category : #'Hermes-Changes-Propagator'
}

{ #category : #connecting }
HEAbstractStampConnected >> connect [
	connection := StampClient new.
	connection
		login: 'guest';
		passcode: 'guest';
		open.

]

{ #category : #accessors }
HEAbstractStampConnected >> connection: aStampClient [ 
	connection := aStampClient
]

{ #category : #connecting }
HEAbstractStampConnected >> disconnect [

	connection
		ifNotNil: [ connection isConnected
				ifTrue: [ connection disconnect ] ]
]

{ #category : #testing }
HEAbstractStampConnected >> isConnected [
	
	^ connection isConnected
]
