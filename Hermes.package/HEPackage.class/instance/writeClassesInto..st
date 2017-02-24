writing
writeClassesInto: aWriter
	aWriter writeInt: classes size.
	classes do: [ :each | each writeInto: aWriter ]