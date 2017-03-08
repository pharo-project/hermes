# Hermes

## Usage

For exporting it should be something like:

```smalltalk
writer := (File named: 'test.hermes') writeStream.

oldPackage := RPackageOrganizer default packageNamed: #'Hermes-Tests-External-Package'.
hePackage := HEPackage for: oldPackage.
hePackage writeInto: writer.
```

And for installing back in the system just do:

```smalltalk
reader := (File named: 'test.hermes') readStream.

readPackage := HEPackage readFrom: reader.
installer := HEInstaller new. 
installer installPackage: readPackage.
```
