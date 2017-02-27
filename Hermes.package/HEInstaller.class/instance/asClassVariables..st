converting
asClassVariables: aString
	^ (aString substrings: ' ') collect: [:x | x asSymbol => ClassVariable]