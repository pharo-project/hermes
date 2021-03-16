Class {
	#name : #HETeSimpleClassWithBlocks,
	#superclass : #Object,
	#instVars : [
		'anInstanceVariable'
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

	^ [ [ 42 ] on: Error do: [ ^ self halt ] ] ensure: [ 4 ].
]
