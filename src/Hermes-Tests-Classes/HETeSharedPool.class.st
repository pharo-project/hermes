"
I am a shared pool used by HETeSimpleClassUsingSharedPool to test that the shared pools of a class are kept when it is exported and installed.
"
Class {
	#name : 'HETeSharedPool',
	#superclass : 'SharedPool',
	#classVars : [
		'ASharedValue'
	],
	#category : 'Hermes-Tests-Classes-SharedPools',
	#package : 'Hermes-Tests-Classes',
	#tag : 'SharedPools'
}

{ #category : 'class initialization' }
HETeSharedPool class >> initialize [

	ASharedValue := 42
]
