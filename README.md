
# QZ Flutter Plugin

A flutter plugin that allow works with the JavaScript library [qz.io](https://qz.io/).

## Run Locally

Get [QZ Tray](https://qz.io/download/) and install it.

Copy in your project the JavaScript files: `qz-tray.js` and `qzSecurity.js` and link them in your `index.html`(See example folder).

```html  
 <!-- web/index.html -->  
 <script src="js/qz-tray.js"></script>  
 <script src="js/qzSecurity.js"></script>  
 
```  

### Signing

You can use backend signing or frontend signing to manage the qz certificates according to your needs. Depending the approach you are going to use there is a few steps to follow before using the plugin.

- **Backend signing** : To use this approach it should be a backend running with the necessary routes. See the [docs](https://qz.io/docs/signing) for more information.
- **Frontend signing** : To use this approach you need to import the [jsrsasign library](https://github.com/kjur/jsrsasign) in your `index.html`.


     ```html 

      <!-- web/index.html --> 

      <!-- jsrsasign library required for JavaScript signing. In production,download and reference a local copy!!-->
      <script src="https://cdn.rawgit.com/kjur/jsrsasign/c057d3447b194fa0a3fdcea110579454898e093d/jsrsasign-all-min.js">
      </script>

     ``` 

  
## API Reference

### Constructor Qz

| Parameter           | Type                     | Description                                                                                                                                                                                                 |
|:--------------------|:-------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `backendMode`       | `bool`                   | If it is set to true it will check the certificate and the signature with urls that should be defined, otherwise it will check the certificate and the signature with `String` values. **Default** `false`. |
| `certificateUrl`    | `String?`                | It is required if `backendMode` is enabled. Represents the url where it is your certificate file.                                                                                                           |
| `signatureUrl`      | `String?`                | It is required if `backendMode` is enabled. Represents the endpoint where the signature is encrypted.                                                                                                       |
| `certificateString` | `String?`                | It is required if `backendMode` is disabled. Represents the content of your certificate.                                                                                                                    |
| `signatureString`   | `String?`                | It is required if `backendMode` is disabled. Represents the content of your private key.                                                                                                                    |
| `algorithm`         | `SHA1`/`SHA256`/`SHA512` | Must be the same as the backend. If you are using frontend signing skip this parameter. **Default** `SHA512`.                                                                                               |

### Qz functions

```dart
String get version
```
- Returns the current version of Qz.

```dart
Future<dynamic> connect()
```
- Check if there is an instance connected and if there is not it connects to QZ Tray.

```dart
Future<List<String>> getAllPrinters()
```
- Returns the name of all available printers in the system.

```dart
Future<dynamic> printPDF({String? printerName, String? base64, List<int>? blob, Uri? uri})
```
- Prints a PDF using `type: pixel`

```dart
Future<dynamic> printRaw({String? printerName, String? base64, List<int>? blob, Uri? uri})
```
- Prints anything using `type: raw` and `format: 'command'`, this is useful when you need to send a file directly to the printer and the printer decides how to print it.

```dart
Future<dynamic> printZPL({String? printerName, required String zpl})
```
- Prints a document using ZPL code, only compatible with ZPL printers.

### Print params
`printerName`: A `String` that represents the printer you want to print to. **Default** Default system printer.

`base64`: A `String` that represents a base64 pdf. **Optional**.

`blob`: A `List<int>` that represents pdf blob data. **Optional**.

`uri`: An `Uri` object containing the address to the pdf file. **Optional**.

**Important** `base64`, `blob` and `uri` are exclusionary fields, i.e., only can pass one on every call and all can't be null.

## Feedback

Any contribution will be welcome, as well as any feedback.