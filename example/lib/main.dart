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
  final _qzWebPlugin = Qz();

  String? printer;
  String? pdfBase64;

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
        floatingActionButton: FloatingActionButton(
          child: const Text('print'),
          onPressed: () async {
            await _qzWebPlugin.print(printerName: printer, base64: pdfBase64);
          },
        ),
        body: Column(
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
                  return Container();
                }),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Base64 string pdf',
              ),
              onChanged: (value) {
                setState(() {
                  pdfBase64 = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
