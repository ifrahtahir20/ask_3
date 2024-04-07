import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class Receipt extends StatefulWidget {
  const Receipt({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  var scr = GlobalKey();
  Future getPdf(Uint8List screenShot, time, tempPath) async {
    pw.Document pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Expanded(
            child: pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.contain),
          );
        },
      ),
    );
    var pathurl = "$tempPath/$time.pdf";

    File pdfFile = File(pathurl);
    pdfFile.writeAsBytesSync(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Transactions Details',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  RepaintBoundary(
                    key: scr,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                "Transaction Date",
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text("5/8/2022",
                                    maxLines: 2,
                                    textAlign: TextAlign.right,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8, top: 20, bottom: 20),
                          child: Row(
                            children: List.generate(
                                150 ~/ 5,
                                (index) => Expanded(
                                      child: Container(
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : Colors.grey,
                                        height: 2,
                                      ),
                                    )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                "Account Number",
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text("3099971756",
                                    maxLines: 2,
                                    textAlign: TextAlign.right,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8, top: 20, bottom: 20),
                          child: Row(
                            children: List.generate(
                                150 ~/ 5,
                                (index) => Expanded(
                                      child: Container(
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : Colors.grey,
                                        height: 2,
                                      ),
                                    )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                "Type",
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text("debit",
                                    maxLines: 2,
                                    textAlign: TextAlign.right,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8, top: 20, bottom: 20),
                          child: Row(
                            children: List.generate(
                                150 ~/ 5,
                                (index) => Expanded(
                                      child: Container(
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : Colors.grey,
                                        height: 2,
                                      ),
                                    )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                "Amount",
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text("\u{20A6}50,000",
                                    maxLines: 2,
                                    textAlign: TextAlign.right,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8, top: 20, bottom: 20),
                          child: Row(
                            children: List.generate(
                                150 ~/ 5,
                                (index) => Expanded(
                                      child: Container(
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : Colors.grey,
                                        height: 2,
                                      ),
                                    )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                "Status",
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text("Success",
                                    maxLines: 2,
                                    textAlign: TextAlign.right,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8, top: 20, bottom: 20),
                          child: Row(
                            children: List.generate(
                                150 ~/ 5,
                                (index) => Expanded(
                                      child: Container(
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : Colors.grey,
                                        height: 2,
                                      ),
                                    )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                "Narration",
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text("Transfer to Banjo Oluwatimilehin",
                                    maxLines: 2,
                                    textAlign: TextAlign.right,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8, top: 20, bottom: 20),
                          child: Row(
                            children: List.generate(
                                150 ~/ 5,
                                (index) => Expanded(
                                      child: Container(
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : Colors.grey,
                                        height: 2,
                                      ),
                                    )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      RenderRepaintBoundary boundary = scr.currentContext!
                          .findRenderObject() as RenderRepaintBoundary;
                      var image = await boundary.toImage();
                      var byteData =
                          await image.toByteData(format: ImageByteFormat.png);
                      var pngBytes = byteData!.buffer.asUint8List();
                      String tempPath = (await getTemporaryDirectory()).path;
                      var dates = DateTime.now().toString();
                      await getPdf(pngBytes, dates, tempPath);
                      var pathurl = "$tempPath/$dates.pdf";
                      await Share.shareFiles([pathurl]);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.height * 0.5,
                      decoration: const BoxDecoration(
                        color: Colors.lightBlue,
                      ),
                      child: Center(
                        child: Text(
                          'Share',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
