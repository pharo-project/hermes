Class {
	#name : #HEChangeSetListener,
	#superclass : #HEAbstractStampConnected,
	#instVars : [
		'subscription',
		'listenerProcess'
	],
	#category : #'Hermes-Changes-Propagator'
}

{ #category : #connecting }
HEChangeSetListener >> connect [

	super connect.

	subscription := connection newSubscriptionTo: 'updates'.
	subscription clientIndividualAck.
	subscription subscribeFrame prefetchCount: 1.
	connection write: subscription subscribeFrame.
	
	listenerProcess := [ [self doLoop] repeat ] newProcess.
	listenerProcess resume.


]

{ #category : #connecting }
HEChangeSetListener >> disconnect [

	listenerProcess ifNotNil: [
		listenerProcess terminate.
		listenerProcess := nil ].
	super disconnect 
]

{ #category : #connecting }
HEChangeSetListener >> doLoop [
	
	| message |

	[	
		message := connection readMessage.
		self processMessage: message.
		connection write: message ackFrame] on: ConnectionTimedOut do: [].
	
]

{ #category : #connecting }
HEChangeSetListener >> processMessage: message [

	| aChangeSet |
	aChangeSet := HEChangeSet new
		readFrom: message body readStream;
		yourself.

	aChangeSet install
]
