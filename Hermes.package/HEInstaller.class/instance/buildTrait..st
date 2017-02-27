creating traits
buildTrait: aTraitDefinition
	| newTrait |
	newTrait := Trait
		named: aTraitDefinition traitName
		uses: (aTraitDefinition traitComposition asLiteralIn: environment)
		category: aTraitDefinition category
		env: environment.

	newTrait classTrait
		traitComposition: (aTraitDefinition classTraitComposition asLiteralIn: environment).

	^ newTrait