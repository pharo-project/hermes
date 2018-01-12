Class {
	#name : #HETraitExclusion,
	#superclass : #HETraitTransformation,
	#category : #'Hermes-Model'
}

{ #category : #accessing }
HETraitExclusion class >> tag [
	^ 21.
]

{ #category : #converting }
HETraitExclusion >> asLiteralIn: env [
	^ self traitExclusionClass new
		exclusions: (value collect: [ :e | e asLiteralIn: env ]);
		subject: (subject asLiteralIn: env);
		yourself
]

{ #category : #converting }
HETraitExclusion >> traitExclusionClass [

	^ Smalltalk globals at: #TraitExclusion ifAbsent: [ self error: 'Trait support is not installed' ].

]

{ #category : #accessing }
HETraitExclusion >> value: aTraitExclusion [
	super value: aTraitExclusion.
	value := aTraitExclusion exclusions collect:#asExportedLiteral.
]
