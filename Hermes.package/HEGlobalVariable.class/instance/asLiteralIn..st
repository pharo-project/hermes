converting
asLiteralIn: env
	| bind undec |
	bind := env newClass bindingOf: value.
	
	bind ifNotNil: [ ^ bind ].
	
	undec := UndeclaredVariable key: value value: nil.
	Undeclared add: undec.
	
	^ undec.