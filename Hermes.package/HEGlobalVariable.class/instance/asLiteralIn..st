converting
asLiteralIn: env
	| bind undec |
	bind := env newClass bindingOf: value.
	
	bind ifNotNil: [ ^ bind ].
	
	undec := UndeclaredVariable named: value.
	Undeclared add: undec.
	
	^ undec.