initialization
tearDown
	aClass ifNotNil: #removeFromSystem.
	super tearDown.
