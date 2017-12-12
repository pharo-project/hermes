Extension { #name : #HETraitLiteral }

{ #category : #'*Hermes-Exporter' }
HETraitLiteral >> allDependenciesIn: aCollection [
	^ aCollection detect: [ :aTrait | aTrait traitName = self value ] ifFound: [ :x | {x} ] ifNone: [ #() ]
]
