Extension { #name : #HETraitComposition }

{ #category : #'*Hermes-Exporter' }
HETraitComposition >> allDependenciesIn: aCollection [
	^ self value flatCollect: [ :aTrait | aTrait allDependenciesIn: aCollection ]
]
