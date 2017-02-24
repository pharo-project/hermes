converting
asLiteralIn: env
	| additionalMethodState |
	additionalMethodState := AdditionalMethodState new.
	additionalMethodState method: env newMethod.
	additionalMethodState selector: (selector asLiteralIn: env).

	value withIndexDo: [ :e :idx | additionalMethodState at: idx put: e ].
	^ additionalMethodState