# Hermes

## Loading Hermes

You can load a specific version using the following expression:

```Smalltalk
Metacello new 
	baseline: 'Hermes';
	repository: 'github://pharo-project/Hermes:<version>';
	load
```

## Usage

For exporting it should be something like:

```smalltalk
fileReference := ('sunit.hermes') asFileReference.
fileName := fileReference fullName.
writer := HEBinaryReaderWriter new
		stream: (File openForWriteFileNamed:fileName);
		yourself.

oldPackage := RPackageOrganizer default packageNamed: #'SUnit-Core'.
hePackage := HEPackage for: oldPackage.
hePackage writeInto: writer.

writer stream flush.

```

And for installing back in the system just do:

```smalltalk
fileReference := ('sunit.hermes') asFileReference.
filename := fileReference fullName.

reader := HEBinaryReaderWriter new
	stream: (File openForReadFileNamed:filename);
	yourself.

readPackage := HEPackage readFrom: reader.
        installer := HEInstaller new. 
        installer installPackage: readPackage.
```
