import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'HiveDatabase/data_box.dart';

class PdfPreviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(),
      ),
    );
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    final ByteData bytes =
        await rootBundle.load('assets/images/udhar_book_logo.jpg');
    final Uint8List byteList = bytes.buffer.asUint8List();
    pdf.addPage(
      pw.Page(
          margin: const pw.EdgeInsets.all(10),
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(children: [
                    pw.Row(
                      children: [
                        pw.Image(pw.MemoryImage(byteList),
                            fit: pw.BoxFit.fitHeight, height: 50, width: 50),
                        pw.Text("  udhaar book",
                            style: pw.TextStyle(fontSize: 30)),
                        pw.SizedBox(width: 100),
                        pw.Text("karobar ka naam",
                            style: pw.TextStyle(
                                fontSize: 30, fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Header(text: "Apna business digital bnao", level: 1),
                      ],
                    ),
                  ]),
                  pw.Divider(
                      borderStyle: pw.BorderStyle.solid, color: PdfColors.grey),
                  pw.Center(
                    child: pw.Column(children: [
                      pw.Paragraph(
                        text: "karobaar ka naam",
                        style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Paragraph(
                        text: "Phone #: ",
                        style: pw.TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      pw.Divider(
                          borderStyle: pw.BorderStyle.solid,
                          color: PdfColors.grey),
                    ]),
                  ),
                  pw.Container(
                    padding: pw.EdgeInsets.all(20),
                    color: PdfColors.grey200,
                    alignment: pw.Alignment.center,
                    child: pw.Container(
                      padding: pw.EdgeInsets.all(10),
                      alignment: pw.Alignment.center,
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Total cash in ",
                                style: pw.TextStyle(
                                    fontSize: 18, color: PdfColors.grey800),
                              ),
                              pw.SizedBox(
                                width: 300,
                              ),
                              pw.Text(
                                "Rs.${DataBox.calculateCashInTotal()}",
                                style: pw.TextStyle(
                                    fontSize: 18, color: PdfColors.grey800),
                              ),
                            ],
                          ),
                          pw.Divider(
                            height: 5,
                            color: PdfColors.grey300,
                          ),
                          pw.SizedBox(
                            height: 5,
                          ),
                          pw.Row(
                            children: [
                              pw.Text(
                                "Total cash out ",
                                style: pw.TextStyle(
                                    fontSize: 18, color: PdfColors.grey800),
                              ),
                              pw.SizedBox(
                                width: 300,
                              ),
                              pw.Text(
                                "Rs.${DataBox.calculateCashOutTotal()}",
                                style: pw.TextStyle(
                                    fontSize: 18, color: PdfColors.grey800),
                              ),
                            ],
                          ),
                          pw.Divider(
                            height: 5,
                            color: PdfColors.grey300,
                          ),
                          pw.SizedBox(
                            height: 5,
                          ),
                          pw.Row(
                            children: [
                              pw.Text(
                                "Net Balance ",
                                style: pw.TextStyle(
                                    fontSize: 18, color: PdfColors.grey800),
                              ),
                              pw.SizedBox(
                                width: 300,
                              ),
                              pw.Text(
                                "Rs.${DataBox.calculateCashInTotal() - DataBox.calculateCashOutTotal()}",
                                style: pw.TextStyle(
                                    color: PdfColors.green500, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.circular(15),
                        color: PdfColors.white,
                      ),
                    ),
                  ),
                  pw.Container(
                    height: 70,
                    color: PdfColors.grey50,
                    padding: pw.EdgeInsets.only(
                        left: 17, right: 10, top: 10, bottom: 5),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Date",
                          style: pw.TextStyle(
                              fontSize: 20, color: PdfColors.grey800),
                        ),
                        pw.SizedBox(
                          width: 190,
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              "Cash In",
                              style: pw.TextStyle(
                                  fontSize: 20, color: PdfColors.grey800),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          width: 150,
                        ),
                        pw.Text(
                          "Cash Out",
                          style: pw.TextStyle(
                              fontSize: 20, color: PdfColors.grey800),
                        ),
                      ],
                    ),
                  ),
                  pw.Container(
                    height: 50,
                    color: PdfColors.grey200,
                    padding: pw.EdgeInsets.only(
                        left: 17, right: 10, top: 10, bottom: 5),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Container(
                    height: 60,
                    // color: PdfColors.grey200,
                    padding: pw.EdgeInsets.only(
                        left: 17, right: 10, top: 10, bottom: 5),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Grand total",
                          style: pw.TextStyle(
                              fontSize: 20, color: PdfColors.grey800),
                        ),
                        pw.SizedBox(
                          width: 150,
                        ),
                        pw.Text("Rs.${DataBox.calculateCashInTotal()}",
                            style: pw.TextStyle(
                                fontSize: 20, color: PdfColors.green500)),
                        pw.SizedBox(
                          width: 150,
                        ),
                        pw.Text(
                          "Rs.${DataBox.calculateCashOutTotal()}",
                          style: pw.TextStyle(
                            fontSize: 20,
                            color: PdfColors.orange800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]);
          }),
    );
    return pdf.save();
  }
}
