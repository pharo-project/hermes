# Hermes implementation

This document gives an overview of how Hermes is built, to help find your way in the code before changing it. The class comments give the details.

- [Packages](#packages)
- [The model](#the-model)
- [The file format](#the-file-format)
- [Exporting](#exporting)
- [Installing](#installing)
- [Compatibility with several Pharo versions](#compatibility-with-several-pharo-versions)
- [Extending Hermes](#extending-hermes)
- [Hermes in Pharo](#hermes-in-pharo)

## Packages

| Package | Content |
|---|---|
| `Hermes` | The model, the reader and the minimal installer. It has to stay small: during the bootstrap of Pharo it is loaded in an image that has no compiler. |
| `Hermes-Exporter` | The writer and the extension methods that convert the code of the image to the model. |
| `Hermes-Exporter-Pharo11` | The export of constant blocks, which only exist since Pharo 11. |
| `Hermes-Extensions` | `HEExtendedInstaller` and its duplication strategies. |
| `Hermes-Ring2` | `HERing2ToHermesBuilder`, which exports code described by a Ring model instead of code loaded in the image. |
| `Hermes-Tests*` | The tests and their fixture classes. |

## The model

The model is a tree of `HEAbstractExported` objects. Each of them knows how to read itself (`#doReadFrom:`, in `Hermes`) and to write itself (`#doWriteInto:`, in `Hermes-Exporter`).

- `HEPackage` is the root of a file: its name, its traits and classes sorted so that each one comes after the ones it depends on, and its extension methods.
- `HEClass` and `HETrait` (subclasses of `HEMethodContainer`) hold the definition of a class or a trait as strings and symbols (names of the superclass, slots, class variables, shared pools, layout class, package and tag), their trait compositions and their methods.
- `HEMethod` holds what is needed to rebuild a compiled method: its selector, class, protocol, encoder (bytecode set), number of arguments and temporaries, primitive flag, bytecode and literals.
- `HEExportedLiteral` and its subclasses represent the literals of the methods and of the trait compositions: numbers, strings, symbols, arrays, variables (global, class or pool variables), pragmas, method properties, blocks, and the message sends used to rebuild a trait composition.

Comparing two model objects compares their instance variables, which the tests use to check that writing and reading a model gives back the same model.

## The file format

The format is platform independent: integers are stored on 4 bytes in little endian, strings as their size followed by their bytes. `HEBinaryReader` reads the basic types, and `HEBinaryReaderWriter` (in `Hermes-Exporter`) also writes them.

A package is written as:

1. the format version (`HEPackage class>>#formatVersion`),
2. the name of the package,
3. the traits, the classes, then the extension methods, each preceded by their number.

Each literal is written as a byte, its tag, followed by its content. Each subclass of `HEExportedLiteral` defines a unique tag on its class side, and `HEExportedLiteral class>>#readFrom:` uses it to find the class to read.

## Exporting

The code of the image is converted by the methods `#asExportedLiteral` added to the classes of literals, and by `#for:` on the class side of the model (`HEPackage for: aPackage`, `HEMethod for: aCompiledMethod`...). A method is exported from its compiled method, not from its source: its bytecode is copied, and each literal is converted. The binding of the method to its class is exported as `nil` since the installer rebuilds it, and the method properties that the image sets itself when a method is installed (`AdditionalMethodState class>>#propertiesToPersist`) are not exported.

Trait compositions are exported by parsing their printed form and converting it to message sends (`HETraitCompositionExporter`), which are evaluated again in the target image.

`HERing2ToHermesBuilder` builds the same model from a Ring environment. It compiles each method against the Ring classes, so this path also depends on Ring understanding what the compiler asks to its variables.

## Installing

`HEInstaller>>#installPackage:` installs a package in this order:

1. ensure the package exists,
2. build the traits, then install their methods,
3. build the classes, then install their methods,
4. install the extension methods,
5. check that no new undeclared variable was created.

The system announcements are stored during the installation and sent at the end, so that the tools do not react to a half installed package.

Classes and traits are built with the class builder of Pharo (`ShiftClassInstaller`), from the strings stored in the model.

Methods are rebuilt in `HEInstaller>>#rebuildMethod:into:`: the installer creates an empty compiled method with the header computed from the model, converts each literal to an object of the target image (`#asLiteralIn:`), copies the bytecode and installs the method with the method installer of the class. `HEExtendedEnvironment` gives the literals what they need to rebuild themselves: the environment to look up classes and globals, and the class, selector, method and block being built (a compiled block needs its outer method).

`HEExtendedInstaller` overrides the checks of `HEInstaller` to apply its duplication strategy and its option on undeclared variables.

## Compatibility with several Pharo versions

Hermes uses the API of the latest Pharo. On older versions, the missing API comes from [PharoBackwardCompatibility](https://github.com/jecisc/PharoBackwardCompatibility), loaded by the baseline. When Hermes needs a method that an older Pharo does not have, add it to PharoBackwardCompatibility rather than testing the version of Pharo in Hermes.

A version check stays where the behaviour differs and not only the API: for example the size of the method trailer, which is fixed since Pharo 12. Code that needs a class missing in the older versions goes in a package loaded only from the version that has it, as `Hermes-Exporter-Pharo11`.

The CI runs the tests on every supported version of Pharo.

## Extending Hermes

To support a new kind of literal:

1. Add a subclass of `HEExportedLiteral` in `Hermes`, with an unused tag on its class side, `#doReadFrom:` and `#asLiteralIn:`.
2. Add `#value:` and `#doWriteInto:` as extensions in `Hermes-Exporter`, and `#asExportedLiteral` on the class of the literal, returning `MyExportedLiteral for: self`.
3. Add a test that exports and installs a method using this literal.

Changing an existing tag or the way an element is written breaks the compatibility with the existing files and requires increasing the format version.

## Hermes in Pharo

Pharo contains its own copy of the packages `Hermes` and `Hermes-Extensions`, which its bootstrap uses to load packages in the image being built. They should be kept in sync with this repository: a change in the model or in the format has to be made in both, or the files exported by this repository cannot be loaded by the image built by the bootstrap.
