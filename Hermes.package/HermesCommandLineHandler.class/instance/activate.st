activation
activate
	self activateHelp ifTrue: [ ^ self ].
	self validateParameters.
	
	self processFiles.
		
	(self hasOption: 'save')
		ifTrue: [ Smalltalk snapshot: true andQuit: false ].

	self exitSuccess