"
I am a visitor for visiting trait compositions.
Each trait composition is visited and translated to a set of HEMessageSend and literals.
"
Class {
	#name : 'HETraitCompositionExporter',
	#superclass : 'Object',
	#category : 'Hermes-Exporter-Traits',
	#package : 'Hermes-Exporter',
	#tag : 'Traits'
}

{ #category : 'instance creation' }
HETraitCompositionExporter class >> export: aTraitComposition [

	^ self new export: aTraitComposition
]

{ #category : 'exporting' }
HETraitCompositionExporter >> export: aTraitComposition [ 
	| node |
	
	node := RBParser parseExpression: aTraitComposition asString.
	
	^ node acceptVisitor: self
]

{ #category : 'visiting' }
HETraitCompositionExporter >> visitArrayNode: aArrayNode [ 
	
	^ (aArrayNode statements collect: [ :e | e acceptVisitor: self ] as: Array) asExportedLiteral
]

{ #category : 'visiting' }
HETraitCompositionExporter >> visitLiteralNode: aLiteralValueNode [ 

	^ aLiteralValueNode value asExportedLiteral
]

{ #category : 'visiting' }
HETraitCompositionExporter >> visitLiteralValueNode: aRBLiteralValueNode [ 
	
	^ self visitLiteralNode: aRBLiteralValueNode  
]

{ #category : 'visiting' }
HETraitCompositionExporter >> visitMessageNode: aMessageNode [ 

	^ HESendMessage
		selector: aMessageNode selector asExportedLiteral 
		receiver: (aMessageNode receiver acceptVisitor: self)
		arguments: (aMessageNode arguments collect: [:e | e acceptVisitor: self ]) asExportedLiteral 
]

{ #category : 'visiting' }
HETraitCompositionExporter >> visitVariableNode: aVariableNode [ 

	^ HETraitLiteral for: aVariableNode
]
