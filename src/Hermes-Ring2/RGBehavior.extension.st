Extension { #name : #RGBehavior }

{ #category : #'*Hermes-Ring2' }
RGBehavior >> categoryOfElement: aSymbol [ 
	
	| aMethod |
	
	aMethod := (self localMethodNamed: aSymbol ifAbsent: nil).
	^ aMethod ifNotNil: [ aMethod protocol ] 
]
