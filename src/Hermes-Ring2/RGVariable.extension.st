Extension { #name : 'RGVariable' }

{ #category : '*Hermes-Ring2' }
RGVariable >> isSelfOrSuperVariable [

	^ self isSelfVariable or: [ self isSuperVariable ]
]

{ #category : '*Hermes-Ring2' }
RGVariable >> isSelfVariable [

	^ false
]

{ #category : '*Hermes-Ring2' }
RGVariable >> isThisContextVariable [

	^ false
]

{ #category : '*Hermes-Ring2' }
RGVariable >> isThisProcessVariable [

	^ false
]
