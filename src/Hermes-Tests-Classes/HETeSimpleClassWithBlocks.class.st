"
I am a class with blocks, the idea is to tests the serialization and de-serialization of full blocks using Sista.
"
Class {
	#name : 'HETeSimpleClassWithBlocks',
	#superclass : 'Object',
	#instVars : [
		'anInstanceVariable',
		'passedTheEnsure'
	],
	#classVars : [
		'AClassVariable'
	],
	#category : 'Hermes-Tests-Classes-Classes',
	#package : 'Hermes-Tests-Classes',
	#tag : 'Classes'
}

{ #category : 'test methods' }
HETeSimpleClassWithBlocks >> aMethodWithABlock [

	^ [
	  self.
	  42 ]
]

{ #category : 'test methods' }
HETeSimpleClassWithBlocks >> aMethodWithACleanBlock [
	"The block does not use self, the instance variables, the outer temporaries nor a non-local return, so it is a clean block since Pharo 14."

	^ [ :number | number + 1 ]
]

{ #category : 'test methods' }
HETeSimpleClassWithBlocks >> aMethodWithAContantBlock [

	^ [ 42 ]
]

{ #category : 'test methods' }
HETeSimpleClassWithBlocks >> aMethodWithNestedBlocks [

	passedTheEnsure := false.

	^ [
	  [
	  self.
	  42 ]
		  on: Error
		  do: [ ^ self halt ] ] ensure: [ passedTheEnsure := true ]
]

{ #category : 'test methods' }
HETeSimpleClassWithBlocks >> passedTheEnsure [

	^ passedTheEnsure
]
