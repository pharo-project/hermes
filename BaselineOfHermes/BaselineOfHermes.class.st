Class {
	#name : #BaselineOfHermes,
	#superclass : #BaselineOf,
	#category : #BaselineOfHermes
}

{ #category : #baselines }
BaselineOfHermes >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec

		package: 'Hermes';
		package: 'Hermes-Exporter' with: [ spec requires: #('Hermes') ];
		package: 'Hermes-Extensions' with: [ spec requires: #('Hermes') ];

		package: 'Hermes-Ring2' with: [ spec requires: #('Hermes-Exporter') ];

		package: 'Hermes-Tests-Classes';
		package: 'Hermes-Tests-External-Package';
		package: 'Hermes-Tests' with: [ spec requires: #('core' 'Hermes-Tests-Classes' 'Hermes-Tests-External-Package') ];
		package: 'Hermes-Tests-Ring' with: [ spec requires: #('core' 'Hermes-Tests-External-Package') ];
		
		group: 'core'
			with: #(Hermes 'Hermes-Exporter' 'Hermes-Extensions' 'Hermes-Ring2');
		group: 'minimal'
			with: #(Hermes);
		group: 'test'
			with: #('Hermes-Tests' 'Hermes-Tests-Classes' 'Hermes-Tests-External-Package')
	]
]
