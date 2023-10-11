"
I am a class with blocks, the idea is to tests the serialization and de-serialization of full blocks using Sista.
"
Class {
	#name : #HETeSimpleClassWithBlocks,
	#superclass : #Object,
	#instVars : [
		'anInstanceVariable',
		'passedTheEnsure'
	],
	#classVars : [
		'AClassVariable'
	],
	#category : #'Hermes-Tests-Classes'
}

{ #category : #'test methods' }
HETeSimpleClassWithBlocks >> aMethodWithABlock [

	^ [ 42 ]
]

{ #category : #'test methods' }
HETeSimpleClassWithBlocks >> aMethodWithNestedBlocks [

	passedTheEnsure := false.

	^ [ [ 42 ] on: Error 
			do: [ ^ self halt ] ] 
			ensure: [ passedTheEnsure := true ].
]

{ #category : #'test methods' }
HETeSimpleClassWithBlocks >> passedTheEnsure [

	^ passedTheEnsure
]
