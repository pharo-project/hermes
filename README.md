# Hermes

[![CI](https://github.com/pharo-project/hermes/actions/workflows/continuous.yml/badge.svg)](https://github.com/pharo-project/hermes/actions/workflows/continuous.yml)

Hermes is a binary format and a set of tools to export Pharo packages and load them in another image without compiling them. A Hermes file contains the classes, traits and methods of a package, with the methods as bytecode. Loading it only needs a small installer, which is why Pharo uses Hermes during its bootstrap to load packages in images that do not have a compiler yet.

Hermes works in Pharo 10 to 15.

- [Installation](#installation)
- [Quick start](#quick-start)
- [Hermes in Pharo](#hermes-in-pharo)
- [Pharo versions compatibility](#pharo-versions-compatibility)
- [Documentation](#documentation)

## Installation

```smalltalk
Metacello new
	githubUser: 'pharo-project' project: 'hermes' commitish: 'master' path: 'src';
	baseline: 'Hermes';
	load
```

To add it to your baseline:

```smalltalk
spec baseline: 'Hermes' with: [ spec repository: 'github://pharo-project/hermes:master/src' ]
```

The default group loads the exporter, the installer and the tests. Use the group `core` to load only the exporter and the installer, or `minimal` for the installer alone.

## Quick start

Export a package to a file:

```smalltalk
| writer |
writer := HEBinaryReaderWriter new
	stream: (File openForWriteFileNamed: 'SUnit-Core.hermes');
	yourself.

(HEPackage for: 'SUnit-Core' asPackage) writeInto: writer.
writer close
```

Load it in another image:

```smalltalk
| reader package |
reader := HEBinaryReader new
	stream: (File openForReadFileNamed: 'SUnit-Core.hermes');
	yourself.

package := HEPackage readFrom: reader.
reader close.

HEInstaller new installPackage: package
```

Or from the command line:

```sh
pharo Pharo.image loadHermes --save SUnit-Core.hermes
```

## Hermes in Pharo

Pharo images already contain the packages `Hermes` and `Hermes-Extensions`: the model, the reader and the installers, and the `loadHermes` command line. They are a copy of the packages of this repository, kept in sync with it. The exporter (`Hermes-Exporter`, `Hermes-Ring2`) and the tests are only in this repository, so you need to load it to export code. Loading it in a Pharo image replaces the two packages of Pharo with the version of this repository.

### In the Pharo bootstrap

The bootstrap of Pharo builds a new image from the sources instead of modifying an existing one. Its first stage only creates a small kernel, which has no compiler. Hermes is how the bootstrap loads the next packages in it:

1. The image running the bootstrap loads this repository and builds a Ring model of the packages of the new image from their sources.
2. It exports with `HERing2ToHermesBuilder` the packages that cannot be loaded with Monticello in the kernel (among them the compiler, the file system, the traits, Monticello and Metacello) to `.hermes` files. The methods are compiled at this step, by the compiler of the image running the bootstrap.
3. The new image installs these files with its own copy of Hermes. Once the compiler and Metacello are installed, the rest of Pharo is loaded from the sources as usual.

This is why the format and the model must stay the same in this repository and in Pharo: the files are written by this repository and read by the copy in the image being built.

## Pharo versions compatibility

| Hermes version | Pharo versions |
|---|---|
| master | 10 to 15 |
| v3.0.x | 10 to 12 |
| v2.x | 9 and older |

Hermes uses the API of the latest Pharo, and relies on [PharoBackwardCompatibility](https://github.com/jecisc/PharoBackwardCompatibility) for the API missing in older versions. The CI runs the tests on every supported version.

Hermes stores bytecode: export and load your files with Pharo versions that share the same bytecode set, and with versions of Hermes using the same format version. See the [user guide](resources/doc/user-guide.md#compatibility-between-images).

## Documentation

- [User guide](resources/doc/user-guide.md): exporting, loading, the installer options and the command line.
- [Implementation](resources/doc/implementation.md): the packages, the file format, how the installer rebuilds classes and methods, and how to extend Hermes.
