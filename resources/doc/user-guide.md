# Hermes user guide

Hermes exports Pharo code to a binary file and installs it in another image without compiling it. This guide explains how to export, how to load, and what to expect from the loaded code.

- [What Hermes stores](#what-hermes-stores)
- [Exporting](#exporting)
- [Loading](#loading)
- [The command line](#the-command-line)
- [Compatibility between images](#compatibility-between-images)

## What Hermes stores

A Hermes file usually contains one package:

- its classes and traits, with their superclass, slots, class variables, shared pools, layout, trait composition, package and tag,
- their methods, as bytecode with their literals, protocols and pragmas,
- the extension methods of the package.

Hermes does not store the source code of the methods. The installed methods work, but they have no source: the tools show their decompiled code.

The installer only needs the classes referenced by the package to exist in the target image. It never compiles anything, so it can run in an image without compiler. This is how the bootstrap of Pharo loads the compiler itself.

## Exporting

Exporting has two steps: build the Hermes model of the code, then write it with a writer on a binary stream.

```smalltalk
| writer |
writer := HEBinaryReaderWriter new
	stream: (File openForWriteFileNamed: 'MyPackage.hermes');
	yourself.

(HEPackage for: 'MyPackage' asPackage) writeInto: writer.
writer close
```

`HEPackage for:` exports the classes, traits and extension methods of a package. The model can also be built for a single class (`HEClass for: aClass`), trait (`HETrait for: aTrait`) or method (`HEMethod for: aCompiledMethod`), but the installer and the command line expect a package as the root of a file.

### Exporting code that is not loaded

The package `Hermes-Ring2` exports code described by a Ring model instead of code loaded in the image. It compiles the methods against the Ring classes, so the code does not need to be loaded:

```smalltalk
hePackage := HERing2ToHermesBuilder new visitPackage: aRingPackage
```

This is what the bootstrap of Pharo uses to export the packages of the image it builds.

## Loading

Read the package from a file, then give it to an installer:

```smalltalk
| reader package |
reader := HEBinaryReader new
	stream: (File openForReadFileNamed: 'MyPackage.hermes');
	yourself.

package := HEPackage readFrom: reader.
reader close.

HEInstaller new installPackage: package
```

The installer creates the package, then the traits, the classes, their methods and the extension methods. The system announcements (class added, method added...) are sent once the whole package is installed.

Load the files in the order of their dependencies: the superclasses, traits and classes extended by a package must exist before it is loaded.

### Errors and options

`HEInstaller` is the minimal installer used during the bootstrap. It fails:

- when a class, trait or method of the package already exists in the image,
- when the installation creates new undeclared variables, which usually means that a dependency was not loaded first.

`HEExtendedInstaller`, in the package `Hermes-Extensions`, can be configured:

```smalltalk
HEExtendedInstaller new
	failOnUndeclared: false;
	duplicationMode: HEReplaceOnDuplication new;
	installPackage: package
```

- `failOnUndeclared: false` only logs the new undeclared variables instead of failing.
- `duplicationMode:` sets what to do when an element already exists: `HEFailOnDuplication` (the default), `HEIgnoreOnDuplication` to keep the version of the image, or `HEReplaceOnDuplication` to replace it with the version of the file.

## The command line

The `loadHermes` command loads files in the given order:

```sh
pharo Pharo.image loadHermes --save MyPackage.hermes MyOtherPackage.hermes
```

- `--save` saves the image after loading the files.
- `--no-fail-on-undeclared` and `--on-duplication=fail|ignore|replace` set the options of the extended installer, when `Hermes-Extensions` is loaded.

## Compatibility between images

- Hermes stores bytecode, not source code, so the target image must use the same bytecode set as the image that exported the code. In practice, export and load with the same version of Pharo, or between versions sharing their bytecode set.
- The file starts with a format version. The installer refuses a file whose version is not the one it knows.
- A newer Pharo can produce literals that an older Hermes does not know, such as the clean blocks the compiler creates by default since Pharo 14. Use a version of Hermes that knows the content of the file.
- Hermes itself works in Pharo 10 to 15. On older versions, it relies on [PharoBackwardCompatibility](https://github.com/jecisc/PharoBackwardCompatibility) for the API added by newer versions of Pharo.
