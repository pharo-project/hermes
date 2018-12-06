Class {
	#name : #BaselineOfHermes,
	#superclass : #BaselineOf,
	#category : #BaselineOfHermes
}

{ #category : #baselines }
BaselineOfHermes >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec
		baseline: 'Ring2' with: [
				spec
					repository: 'github://carolahp/Ring2:master/src' ];
				
		project: 'Ficus' with: [
			spec
				className: #ConfigurationOfFicus;
				versionString: '0.3.8';
				loads: #(FicusRing FicusMonticello);
				repository: 'http://smalltalkhub.com/mc/MartinDias/Ficus/main' ];

		package: 'Hermes';
		package: 'Hermes-Exporter' with: [ spec requires: #('Hermes') ];
		package: 'Hermes-Extensions' with: [ spec requires: #('Hermes') ];

		package: 'Hermes-Tests-External-Package';
		package: 'Hermes-Tests' with: [ spec requires: #('core' 'Hermes-Tests-External-Package') ];
		package: 'Hermes-Tests-Ring' with: [ spec requires: #('core' 'Hermes-Tests-External-Package' 'Ring2') ];
		
		group: 'core'
			with: #(Hermes 'Hermes-Exporter' 'Hermes-Extensions');
		group: 'minimal'
			with: #(Hermes);
		group: 'test'
			with: #('Hermes-Tests' 'Hermes-Tests-External-Package')
	]
]
