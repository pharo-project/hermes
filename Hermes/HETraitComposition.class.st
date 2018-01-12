Class {
	#name : #HETraitComposition,
	#superclass : #HEArray,
	#category : #'Hermes-Model'
}

{ #category : #accessing }
HETraitComposition class >> tag [
	^18
]

{ #category : #converting }
HETraitComposition >> asLiteralIn: env [
	^ self traitCompositionClass new
		transformations: (value collect: [ :e | e asLiteralIn: env ]) asOrderedCollection;
		yourself
]

{ #category : #accessing }
HETraitComposition >> traitCompositionClass [
	^ Smalltalk globals at: #TraitComposition ifAbsent: [ self error: 'Trait support is not installed' ].

]

{ #category : #accessing }
HETraitComposition >> value: aTraitComposition [
	value := aTraitComposition transformations asArray collect:#asExportedLiteral.
]
