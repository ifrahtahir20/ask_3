import 'package:cashinout/pdfpreview.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/invoiceninja.dart';
import 'package:invoiceninja/models/client.dart';
import 'package:invoiceninja/models/invoice.dart';
import 'package:invoiceninja/models/product.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String text = "My Flutter App";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Articles page"),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                  height: 400,
                  width: 400,
                  child: Image.asset("assets/images/udhar_book_logo.jpg")),
              Text(text),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return PdfPreviewPage();
            }));
          },
          child: const Icon(Icons.picture_as_pdf_sharp),
        ),
      ),
    );
  }
}
