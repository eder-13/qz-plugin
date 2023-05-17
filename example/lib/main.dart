import 'package:flutter/material.dart';

import 'package:qz/qz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _qzWebPlugin = Qz(
    certificateString: '''
      Your digital-certificate.txt value 
    ''',
    signatureString: '''
      Your private-key.pem value
    ''',
  );

  String? printer;
  String pdfBase64 = '''
^XA
^FO50,60^A0,40^FDPrinting ZPL^FS
^FO60,120^BY3^BCN,60,,,,A^FD1234ABC^FS
^FO25,25^GB380,200,2^FS
^XZ
  ''';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Running QZ Tray ${_qzWebPlugin.getQzVersion()}'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder(
                  future: _qzWebPlugin.getAllPrinters(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButtonFormField(
                          value: printer,
                          items: snapshot.data
                              ?.map((element) => DropdownMenuItem(
                                    value: element,
                                    child: Text(element),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              printer = value;
                            });
                          });
                    }
                    return const SizedBox();
                  }),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Base64 string pdf',
                ),
                onChanged: (value) {
                  pdfBase64 = value;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      _qzWebPlugin.print(
                          printerName: printer, base64: pdfBase64);
                    },
                    child: const Text('Print')),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      _qzWebPlugin.printZpl(zplString: pdfBase64);
                    },
                    child: const Text('Print ZPL')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
