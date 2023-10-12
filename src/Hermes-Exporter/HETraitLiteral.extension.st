Extension { #name : 'HETraitLiteral' }

{ #category : '*Hermes-Exporter' }
HETraitLiteral >> allDependenciesIn: aCollection [
	"I am used to check that all my dependencies are fulfilled before myself"
	^ aCollection detect: [ :aTrait | aTrait traitName = self value ] ifFound: [ :x | {x} ] ifNone: [ #() ]
]
