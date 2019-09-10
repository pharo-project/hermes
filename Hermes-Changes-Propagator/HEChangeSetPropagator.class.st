Class {
	#name : #HEChangeSetPropagator,
	#superclass : #HEAbstractStampConnected,
	#category : #'Hermes-Changes-Propagator'
}

{ #category : #operations }
HEChangeSetPropagator >> propagate: aHEChangeSet [ 
	
	| sendFrame |
	sendFrame := connection newSendFrameTo: 'updates'.
	sendFrame bytes: (ByteArray streamContents: [ :s | aHEChangeSet writeTo: s ]).
	connection write: sendFrame.
	
]
