accessing
classNamed: aSymbol
	aSymbol ifNil: [ ^ nil ].
	^ self environment at: aSymbol