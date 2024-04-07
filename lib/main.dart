import 'package:cashinout/CashBook/cashbook.dart';
import 'package:cashinout/Customer/loginscreen.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'CashBook/AfterAmount.dart';
import 'Customer/afterrecord.dart';
import 'HiveDatabase/data_box.dart';
import 'HiveDatabase/data_record.dart';
import 'changenotifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataBox.GetHiveFunction();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  CustomerSupplier? customerSupplier;
  MyApp({this.customerSupplier});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CounterModel(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              body: widget.customerSupplier != null
                  ? AfterRecord()
                  : LoginScreen()),
        ));
  }
}

// import 'package:cashinout/pdfpreview.dart';
// import 'package:flutter/material.dart';
// import 'package:invoiceninja/invoiceninja.dart';
// import 'package:invoiceninja/models/client.dart';
// import 'package:invoiceninja/models/invoice.dart';
// import 'package:invoiceninja/models/product.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   String text = "My Flutter App";
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => PdfPreviewPage(text),
//               ),
//             );
//           },
//           child: const Icon(Icons.picture_as_pdf_sharp),
//         ),
//         appBar: AppBar(
//           title: const Text("Articles page"),
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               Container(
//                   height: 400,
//                   width: 400,
//                   child: Image.asset("assets/images/udhar_book_logo.jpg")),
//               Text(text),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
