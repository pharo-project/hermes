"
I am a class using a shared pool, used to test that the shared pools of a class are kept when it is exported and installed.
"
Class {
	#name : 'HETeSimpleClassUsingSharedPool',
	#superclass : 'Object',
	#pools : [
		'HETeSharedPool'
	],
	#category : 'Hermes-Tests-Classes-SharedPools',
	#package : 'Hermes-Tests-Classes',
	#tag : 'SharedPools'
}

{ #category : 'accessing' }
HETeSimpleClassUsingSharedPool >> sharedValue [

	^ ASharedValue
]
