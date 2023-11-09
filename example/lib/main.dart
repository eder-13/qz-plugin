import 'package:flutter/material.dart';

import 'package:qz/qz.dart';
import 'package:qz_example/resources.dart';

void main() {
  runApp(const MyApp());
}

class PrinterWrapper {
  final String title;
  final String? name;

  const PrinterWrapper({
    required this.title,
    this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrinterWrapper &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name?.hashCode ?? 0;
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

  static const defaultPrinter = PrinterWrapper(title: 'Use default printer');
  PrinterWrapper? printer = defaultPrinter;
  String? pdfBase64Input;
  String zplSample = '''
^XA^FO17,16^GB379,371,8^FS^FT65,255^A0N,135,134^FDTEST^FS^XZ
  ''';

  String? errorText;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Running QZ Tray ${_qzWebPlugin.version}'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder(
                      future: _qzWebPlugin
                          .getAllPrinters()
                          .timeout(const Duration(seconds: 5)),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<PrinterWrapper> printers = [
                            defaultPrinter,
                            ...snapshot.data
                                    ?.map((item) =>
                                        PrinterWrapper(title: item, name: item))
                                    .toList() ??
                                [],
                          ];
                          return DropdownButtonFormField<PrinterWrapper>(
                              value: printer,
                              items: printers
                                  .map((printer) => DropdownMenuItem(
                                        value: printer,
                                        child: Text(printer.title),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  printer = value;
                                });
                              });
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LinearProgressIndicator();
                        }
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (snapshot.hasError) ...[
                              Text(
                                '${snapshot.error?.toString()}\n Check you are using the correct "certificateString" and "signatureString" when building QZ plugin.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error),
                              ),
                              const SizedBox(height: 8),
                            ],
                            ElevatedButton(
                              onPressed: () {
                                setState(() {});
                              },
                              child: const Text('Reload printers'),
                            ),
                          ],
                        );
                      }),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Base64 string pdf',
                      errorText: errorText,
                    ),
                    onChanged: (value) {
                      pdfBase64Input = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        if (pdfBase64Input?.isEmpty ?? true) {
                          errorText = 'Base 64 PDF input can not be empty';
                          setState(() {});
                          return;
                        } else {
                          errorText = null;
                          setState(() {});
                        }
                        _qzWebPlugin.printPDF(
                            printerName: printer?.name, base64: pdfBase64Input);
                      },
                      child: const Text('Print PDF From Base64 Input')),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        _qzWebPlugin.printPDF(
                            printerName: printer?.name,
                            base64: pdfBase64Sample);
                      },
                      child: const Text('Print PDF Bas64 Sample')),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        _qzWebPlugin.printPDF(
                            printerName: printer?.name,
                            uri: Uri.tryParse('assets/ticket.pdf'));
                      },
                      child: const Text('Print PDF File Sample')),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        _qzWebPlugin.printRaw(
                            printerName: printer?.name,
                            base64: pdfBase64Sample);
                      },
                      child: const Text('Print PDF Base64 Sample Raw')),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        _qzWebPlugin.printRaw(
                            printerName: printer?.name,
                            uri: Uri.tryParse('assets/ticket.pdf'));
                      },
                      child: const Text('Print PDF File Sample Raw')),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        _qzWebPlugin.printZPL(
                            printerName: printer?.name, zpl: zplSample);
                      },
                      child: const Text('Print ZPL Sample')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
