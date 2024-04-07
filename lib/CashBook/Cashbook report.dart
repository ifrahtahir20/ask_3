import 'package:pdf/widgets.dart' as pw;
import 'package:cashinout/CashBook/finalbalance.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import '../HiveDatabase/data_box.dart';
import '../HiveDatabase/data_record.dart';
import '../pdfpreview.dart';

class CashbookReport extends StatefulWidget {
  const CashbookReport({Key? key}) : super(key: key);

  @override
  State<CashbookReport> createState() => _CashbookReportState();
}

class _CashbookReportState extends State<CashbookReport> {
  PageController _pageController = PageController(initialPage: 0);
  double _dividerPosition = 0.0; // Initial position of the divider
  GlobalKey _dailystatement_key = GlobalKey();
  GlobalKey _accountstatement_key = GlobalKey();
  late Box<KhataRecord> transactionBox;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
        title: Text("Cash book Report"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(top: 5, right: 10, left: 10),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildOptionButton(
                            'Daily Statement', 0, _dailystatement_key),
                        buildOptionButton(
                            'Account Statement', 1, _accountstatement_key),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    color: Colors.grey,
                    // width: 130,
                    width: MediaQuery.of(context).size.width,
                    child: Divider(
                      height: 3,
                      thickness: 4,
                      color: Colors.black,
                      indent: _dividerPosition,
                      endIndent: 10,
                    ),
                  ),
                  SizedBox(
                    height: 575,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _dividerPosition =
                              index * MediaQuery.of(context).size.width / 2;
                        });
                      },
                      children: [
                        buildScreen('Daily Statement'),
                        buildScreen('Account Statement'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOptionButton(String title, int index, GlobalKey key) {
    return ElevatedButton(
      key: key,
      onPressed: () {
        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        final RenderBox? renderBox =
            key.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          setState(() {
            _dividerPosition = renderBox.localToGlobal(Offset.zero).dx;
          });
        }
      },
      child: Text(
        title,
        style: TextStyle(fontSize: 18, color: Colors.black54),
        overflow: TextOverflow.visible,
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.only(right: 25, left: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }

  Widget buildScreen(String type) {
    if (type == 'Daily Statement') {
      return DailyStatement();
    } else {
      return AccountStatement();
    }
  }
}

class AccountStatement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Total cash in ",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    Text(
                      "Rs.${DataBox.calculateCashInTotal()}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Divider(
                  height: 5,
                  color: Colors.grey.shade300,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Total cash out ",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 140,
                    ),
                    Text(
                      "Rs.${DataBox.calculateCashOutTotal()}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Divider(
                  height: 5,
                  color: Colors.grey.shade300,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Net Balance ",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 155,
                    ),
                    Text(
                      "Rs.${DataBox.calculateCashInTotal() - DataBox.calculateCashOutTotal()}",
                      style: TextStyle(color: Color(0xFF4CBB17), fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
          ),
        ),
        Divider(
          height: 2,
          color: Colors.grey.shade400,
        ),
        Container(
          height: 70,
          color: Colors.grey.shade200,
          padding: EdgeInsets.only(left: 17, right: 10, top: 14, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                  ),
                  SizedBox(
                    width: 120,
                  ),
                  Text(
                    "Cash In",
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Cash Out",
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    " Enteries",
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 2,
          color: Colors.grey.shade300,
        ),
        Expanded(
          child: ValueListenableBuilder<Box<KhataRecord>>(
              valueListenable: DataBox.DataRecordBox().listenable(),
              builder: (context, box, _) {
                final records = box.values.toList().reversed.toList();
                return ListView.builder(
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    final transaction = records[index];
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        title: SizedBox(
                            width: 175,
                            child: Column(children: [
                              Row(
                                children: [
                                  Text(
                                    "${DateFormat('d MMM').format(transaction.entryDate)} , ",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Icon(
                                    Icons.circle,
                                    size: 8,
                                  ),
                                  Text(
                                    "  ${DateFormat('h:mm a').format(transaction.entryDate)}",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      color: Colors.green.shade50,
                                      child: Text(
                                        'Bal.Rs. ',
                                        style: TextStyle(fontSize: 15),
                                      )),
                                ],
                              ),
                            ])),
                        trailing: SizedBox(
                          width: 190,
                          child: Row(
                            children: [
                              Container(
                                width: 90,
                                child: Text(
                                  " Rs.${transaction.cashIn}",
                                  style: TextStyle(
                                      fontSize: 20, color: Color(0xFF4CBB17)),
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 30,
                                child: Text(
                                  " Rs.${transaction.cashOut}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orange.shade800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        )
      ],
    );
  }
}

class DailyStatement extends StatelessWidget {
  String text = "My Flutter App";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 13, bottom: 13, right: 5, left: 5),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 126,
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Rs.${DataBox.calculateCashInTotal()}",
                                  style: TextStyle(
                                      fontSize: 20, color: Color(0xFF4CBB17))),
                            ],
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Total Cash in",
                                style: TextStyle(color: Colors.grey.shade800),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                              width: 2.0, color: Colors.grey.shade300),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 126,
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Rs.${DataBox.calculateCashOutTotal()}",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.orange.shade800,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Total Cash out",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                              width: 2.0, color: Colors.grey.shade300),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 126,
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "Rs.${DataBox.calculateCashInTotal() - DataBox.calculateCashOutTotal()} ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal.shade800)),
                            ],
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Net Balance",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                              width: 2.0, color: Colors.grey.shade300),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 70,
            color: Colors.grey.shade200,
            padding: EdgeInsets.only(left: 17, right: 10, top: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Date",
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                ),
                SizedBox(
                  width: 100,
                ),
                Text(
                  "Cash In",
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Cash Out",
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Box<KhataRecord>>(
                valueListenable: DataBox.DataRecordBox().listenable(),
                builder: (context, box, _) {
                  final records = box.values.toList().reversed.toList();
                  return ListView.builder(
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      final transaction = records[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (builder) => FinalBalance(),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          child: ListTile(
                            title: SizedBox(
                                width: 175,
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${DateFormat('d MMM yy').format(transaction.entryDate)} ",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
                                          color: Colors.green.shade50,
                                          child: Text(
                                            'Bal.Rs. ',
                                            style: TextStyle(fontSize: 15),
                                          )),
                                    ],
                                  ),
                                ])),
                            trailing: SizedBox(
                              width: 190,
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    child: Text(
                                      " Rs.${transaction.cashIn}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF4CBB17)),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 30,
                                    child: Text(
                                      " Rs.${transaction.cashOut}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.orange.shade800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
          SizedBox(
            height: 200,
          ),
          Container(
            height: 90,
            color: Colors.grey.shade200,
            padding: EdgeInsets.only(left: 17, right: 10, top: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Grand total",
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                ),
                SizedBox(
                  width: 50,
                ),
                Text("Rs.${DataBox.calculateCashInTotal()}",
                    style: TextStyle(fontSize: 20, color: Color(0xFF4CBB17))),
                SizedBox(
                  width: 25,
                ),
                Text(
                  "Rs.${DataBox.calculateCashOutTotal()}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.orange.shade800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfPreviewPage(),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      child: Icon(
                        Icons.arrow_circle_down_sharp,
                        color: Colors.white,
                        size: 30,
                      ),
                      alignment: Alignment.center,
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Download ",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Row(
                      children: [
                        Text(
                          " Report",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            style: ElevatedButton.styleFrom(
              elevation: 10,
              maximumSize: Size(160, 50),
              backgroundColor: Colors.brown.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// pw.Expanded(
// child: pw.ValueListenableBuilder<Box<KhataRecord>>(
// valueListenable: DataBox.DataRecordBox().listenable(),
// builder: (context, box, _) {
// final records = box.values.toList().reversed.toList();
// return ListView.builder(
// itemCount: records.length,
// itemBuilder: (context, index) {
// final transaction = records[index];
// return Card(
// color: Colors.white,
// child: ListTile(
// title: SizedBox(
// width: 175,
// child: Column(children: [
// Text(
// "${DateFormat('d MMM yy').format(transaction.entryDate)} ",
// style: TextStyle(fontSize: 18),
// ),
// Row(
// children: [
// Container(
// padding: EdgeInsets.only(
// left: 5, right: 5),
// color: Colors.green.shade50,
// child: Text(
// 'Bal.Rs. ',
// style: TextStyle(fontSize: 15),
// )),
// ],
// ),
// ])),
// trailing: SizedBox(
// width: 190,
// child: Row(
// children: [
// Container(
// width: 90,
// child: Text(
// " Rs.${transaction.cashIn}",
// style: TextStyle(
// fontSize: 20,
// color: Color(0xFF4CBB17)),
// ),
// ),
// Container(
// width: 100,
// height: 30,
// child: Text(
// " Rs.${transaction.cashOut}",
// style: TextStyle(
// fontSize: 20,
// color: Colors.orange.shade800,
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// );
// },
// );
// }),
// ),
