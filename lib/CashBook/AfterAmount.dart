import 'package:cashinout/Customer/loginscreen.dart';
import 'package:cashinout/CashBook/update.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'Cashbook report.dart';

import 'AddAmount.dart';
import '../HiveDatabase/data_box.dart';
import '../HiveDatabase/data_record.dart';

class CashBookScreen extends StatefulWidget {
  // final int? totalBalance;
  final int selectedIndex;
  CashBookScreen({
    required this.selectedIndex,
    // this.totalBalance
  });

  @override
  State<CashBookScreen> createState() => _CashBookScreenState();
}

class _CashBookScreenState extends State<CashBookScreen> {
  double _dividerPosition = 0.0;
  int CashInTotal = 0;
  int CashOutTotal = 0;
  int totalBalance = 0;
  late bool isCashIn = true;
  late Box<KhataRecord> transactionBox;
  // late int totalBalance = totalBalance;
  final amountController = TextEditingController();

  @override
  void initState() {
    setState(() {
      CashOutTotal = DataBox.calculateCashOutTotal();
      CashInTotal = DataBox.calculateCashInTotal();
      totalBalance = DataBox.calculateTotalBalance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 100,
      //   automaticallyImplyLeading: false,
      //   title:
      //   Consumer<CounterModel>(builder: (context, counterModel, child) {
      //     return InkWell(
      //       onTap: () {
      //         // counterModel.addnew();
      //       },
      //       child: Column(
      //         children: [
      //           Column(
      //             children: [
      //               Row(
      //                 children: [
      //                   Row(
      //                     children: [
      //                       Text(
      //                         'CashBook',
      //                         style: TextStyle(fontSize: 20),
      //                       ),
      //                       SizedBox(
      //                         width: 110,
      //                       ),
      //                       InkWell(
      //                         onTap: () {},
      //                         child: Column(
      //                           children: [
      //                             Icon(
      //                               Icons.backup_outlined,
      //                               size: 20,
      //                               color: Colors.red,
      //                             ),
      //                             SizedBox(height: 2),
      //                             Text(
      //                               'Backup',
      //                               style: TextStyle(fontSize: 15),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   SizedBox(
      //                     width: 100,
      //                   ),
      //                 ],
      //               ),
      //               Row(
      //                 children: [
      //                   Text(
      //                     "My business",
      //                     style: TextStyle(fontSize: 17),
      //                   ),
      //                   Icon(
      //                     Icons.keyboard_arrow_down,
      //                     size: 17,
      //                   ),
      //                 ],
      //               )
      //             ],
      //           ),
      //         ],
      //       ),
      //     );
      //   }),
      // ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: 160,
                height: 40,
                alignment: Alignment.topLeft,
                padding:
                    EdgeInsets.only(top: 5, right: 20, left: 15, bottom: 3),
                child: Text(
                  "Transactions",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade900),
                )),
            SizedBox(
              width: 160,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CashbookReport()),
                );
              },
              child: Container(
                width: 50,
                height: 30,
                child: Center(
                  child: Text(
                    "PDF",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 20),
          padding: EdgeInsets.only(left: 8, right: 230),
          color: Colors.grey.shade300,
          width: MediaQuery.of(context).size.width,
          child: Divider(
            height: 3,
            thickness: 5,
            color: Colors.black,
            indent: _dividerPosition,
            endIndent: 0.0,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 115,
                    height: 100,
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
                              "Cash in",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.shade100,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Container(
                    width: 115,
                    height: 100,
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
                              "Cash out",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.shade100,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Container(
                    width: 115,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Rs.${DataBox.calculateCashInTotal() - DataBox.calculateCashOutTotal()} ",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.teal.shade800)),
                          ],
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Final Balance",
                              style: TextStyle(color: Colors.teal.shade800),
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.shade100,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Card(
          child: Container(
            height: 50,
            padding: EdgeInsets.only(left: 17, right: 10, top: 10, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Date",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                SizedBox(
                  width: 130,
                ),
                Text(
                  "Cash In",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Cash Out",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 3,
          thickness: 5,
          color: Colors.grey.shade100,
          indent: 10,
          endIndent: 10,
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
                            builder: (builder) => UpDel(
                              index: index,
                              record: transaction,
                              onLoad: () {
                                setState(() {
                                  //   totalBalance -= transaction.cashIn;
                                  //  totalBalance += transaction.cashOut;
                                });
                              },
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          title: SizedBox(
                            width: 175,
                            child: Row(
                              children: [
                                Text(
                                  '${DateFormat('d MMM').format(transaction.entryDate)} , ${DateFormat('h:mm a').format(transaction.entryDate)}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                )
                              ],
                            ),
                          ),
                          trailing: SizedBox(
                            width: 180,
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
                                // SizedBox(
                                //   width: 1,
                                // ),
                                Container(
                                  width: 90,
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
        Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          constraints: BoxConstraints(maxWidth: double.infinity),
          height: 100,
          color: Colors.cyan.shade50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddAmount(isCashIn: true)),
                  );
                },
                child: Text(
                  "CASH IN",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  minimumSize: Size(150, 60),
                  backgroundColor: Color(0xFF4CBB17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddAmount(isCashIn: false)),
                  );
                },
                child: Text(
                  "CASH OUT",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  minimumSize: Size(150, 60),
                  backgroundColor: Colors.orange.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Udhaar Book',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Cash Book',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Money',
            ),
          ],
          currentIndex: widget.selectedIndex,
          onTap: (index) {
            if (index != widget.selectedIndex) {
              Navigator.pop(context); // Close the current screen
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              } else if (index == 2) {
                // Navigator.push(
                // context,
                // MaterialPageRoute(builder: (context) => MoneyScreen()),
                // );
              }
            }
          }),
    );
  }
}
