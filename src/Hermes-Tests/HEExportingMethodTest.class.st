Class {
	#name : 'HEExportingMethodTest',
	#superclass : 'HEAbstractBinaryClassBuilderTest',
	#category : 'Hermes-Tests-Exporting',
	#package : 'Hermes-Tests',
	#tag : 'Exporting'
}

{ #category : 'tests' }
HEExportingMethodTest >> testAllObjectMethods [
	| olds news |
	olds := Object methods collect: [ :e | HEMethod for: e ].
	olds
		do: [ :e | 
			e writeInto: writer.
			writer flush ].

	news := (1 to: olds size) collect: [ :idx | HEMethod readFrom: reader ].
	self assert: olds equals: news
]

{ #category : 'tests' }
HEExportingMethodTest >> testSingleMethod [

	| old new |
	old := HEMethod for: Behavior >> #basicNew:.
	old writeInto: writer.
	writer flush.

	new := HEMethod readFrom: reader.

	self assert: old name equals: #basicNew:.
	self assert: old equals: new.

	"The last literal is the class binding, exported as nil because the installer rebuilds it, and the one before is the method state. Since Pharo 14, the method state can hold properties before the pragma."
	self assert: old literals last species equals: HEUndefinedObject.
	self assert: ((old literals at: old literals size - 1) value value detect: [ :element | element species = HEPragma ]) keyword value equals: #primitive:error:
]
