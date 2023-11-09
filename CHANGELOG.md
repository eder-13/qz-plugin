## v1.0.0+1
### Added
- `printRaw` function added to do print requests using `type: 'raw'` and `format: 'command'`.
- `print` function added to allow to manually do any kind of print request.
- `disconnect` function added.

### Changed
- Breaking change: `printZpl` function renamed to `printZPL`
- Breaking change: `getQzVersion` function renamed to `version` property
- Breaking change: `QzIo` full refactored to be static
- Sample project updated to show how to use `printRaw`, `printPDF` and `printZPL` functions from `base64`, `file` and `String` sources. 


## v0.2.2+8

### 2023-05-25

- Add reload connection functionality

## v0.2.1+7

### 2023-05-17

- Implicitly add Dart 3 support

## v0.2.1+6

### 2023-02-24

- Fix error when building in platforms other than web

## v0.2.0+5

### 2023-02-22

- Add support for ZPL printing

## v0.1.1+4

### 2023-02-16

- 🎉 first release!
