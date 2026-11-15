"
This class has a method refering an undeclared.
"
Class {
	#name : 'HETeSimpleClassReferingClass',
	#superclass : 'Object',
	#instVars : [
		'anInstanceVariable'
	],
	#classVars : [
		'AClassVariable'
	],
	#category : 'Hermes-Tests-Classes-Classes',
	#package : 'Hermes-Tests-Classes',
	#tag : 'Classes'
}

{ #category : 'test mock' }
HETeSimpleClassReferingClass >> simpleMethod [
	^ HETeSimpleClass
]
