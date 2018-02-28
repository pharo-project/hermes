"
Just a Simple class used for tests
"
Class {
	#name : #HETeSimpleClass,
	#superclass : #Object,
	#instVars : [
		'anInstanceVariable'
	],
	#classVars : [
		'AClassVariable'
	],
	#classInstVars : [
		'aClassInstanceVariable'
	],
	#category : #'Hermes-Tests-Test-Classes'
}

{ #category : #'instance creation' }
HETeSimpleClass class >> newInstance [
	^ self new.
]

{ #category : #accessing }
HETeSimpleClass >> anInstanceVariable [
	^ anInstanceVariable
]

{ #category : #accessing }
HETeSimpleClass >> anInstanceVariable: anObject [
	anInstanceVariable := anObject
]

{ #category : #'a protocol so useful' }
HETeSimpleClass >> anUselessMethodWithPragma [
	<someUselessPragma: 1 withArgs: #(1 2 3) with: #HETeSimpleClass>
]

{ #category : #accessing }
HETeSimpleClass >> answer [
	^ 42
]

{ #category : #'a protocol so useful' }
HETeSimpleClass >> otherMethod [
	^ self anInstanceVariable 
]

{ #category : #'a protocol so useful' }
HETeSimpleClass >> pragmaMethod [
	<pragma>
]

{ #category : #'a protocol so useful' }
HETeSimpleClass >> usingAConstant [
	^ NumberParser parse:'42'.
]

{ #category : #'a protocol so useful' }
HETeSimpleClass >> usingMoreConstants [
	^ true printString , #() printString , #asd printString , 1.223 printString
		, #[1 2 3] printString, $A printString
]
