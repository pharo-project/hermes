converting
asSlots: aString
	^ (aString splitOn: ' ') collect: [ :e | e asSymbol asSlot ] as: Array