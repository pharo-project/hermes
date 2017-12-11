initialization
tearDown
	aClass ifNotNil: #removeFromSystem.
	aTrait ifNotNil: #removeFromSystem.

	UndefinedObject removeSelector: #xxx.
	Undeclared removeKey: #AUndeclared ifAbsent:[].

	super tearDown.
