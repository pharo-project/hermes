Class {
	#name : #HETraitAlias,
	#superclass : #HETraitTransformation,
	#category : #'Hermes-Model'
}

{ #category : #accessing }
HETraitAlias class >> tag [
	^ 20.
]

{ #category : #converting }
HETraitAlias >> asLiteralIn: env [
	^ self traitAliasClass new
		aliases: (value collect: [ :e | e asLiteralIn: env ]);
		subject: (subject asLiteralIn: env);
		yourself
]

{ #category : #converting }
HETraitAlias >> traitAliasClass [
	^ Smalltalk globals at: #TraitAlias ifAbsent: [ self error: 'Trait support is not installed' ].

]

{ #category : #accessing }
HETraitAlias >> value: aTraitAlias [
	super value:aTraitAlias.
	value := aTraitAlias aliases collect:#asExportedLiteral.
	
]
