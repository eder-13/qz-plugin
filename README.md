
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

To run the project with certificates it should be a backend running with the necessary routes. See the [docs](https://qz.io/docs/signing) for more information.


## API Reference

### Constructor Qz


| Parameter        | Type                     | Description                                                                                     |
|:-----------------|:-------------------------|:------------------------------------------------------------------------------------------------|
| `secureMode`     | `bool`                   | If it is set to true it will check the certificate and the signature. **Default** `false`.      |
| `certificateUrl` | `String?`                | It is required if `secureMode` is enabled. Represent the url where it is your certificate file. |
| `signatureUrl`   | `String?`                | It is required if `secureMode` is enabled. Represent the endpoint where signature is encrypted. |
| `algorithm`      | `SHA1`/`SHA256`/`SHA512` | Must be the same as the backend. **Default** `SHA512`.                                          |


### Qz methods


#### `String getQzVersion()`

Returns the current version of Qz.

#### `Future<dynamic> connect()`
Check if there is an instance connected and if there is not it connects to QZ Tray.

#### `Future<List<String>> getAllPrinters()`
Returns the name of all available printers in the system.

#### `Future<dynamic> print({String? printerName, String? base64, List<int>? blob, Uri? uri})`
`printerName`: A `String` that represents the printer you want to print to. **Default** Default system printer.

`base64`: A `String` that represents a base64 pdf. **Optional**.

`blob`: A `List<int>` that represents pdf blob data. **Optional**.

`uri`: An `Uri` object containing the address to the pdf file. **Optional**.

**Important**
`base64`, `blob` and `uri` are exclusionary fields, i.e., only can pass one on every call and all can't be null.

## Feedback

Any contribution will be welcome, as well as any feedback.

