Extension { #name : #RGMethod }

{ #category : #'*Hermes-Ring2' }
RGMethod >> acceptVisitor: aVisitor [ 
	^ aVisitor visitMethod: self
]

{ #category : #'*Hermes-Ring2' }
RGMethod >> header [

	^ 7
]
