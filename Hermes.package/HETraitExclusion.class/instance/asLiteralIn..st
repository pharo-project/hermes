converting
asLiteralIn: env
	^ TraitExclusion new
		exclusions: (value collect: [ :e | e asLiteralIn: env ]);
		yourself