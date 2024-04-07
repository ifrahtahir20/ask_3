import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../HiveDatabase/data_box.dart';
import '../HiveDatabase/data_record.dart';
import 'AddAmount.dart';

class FinalBalance extends StatefulWidget {
  const FinalBalance({Key? key}) : super(key: key);

  @override
  State<FinalBalance> createState() => _FinalBalanceState();
}

class _FinalBalanceState extends State<FinalBalance> {
  String formattedDate = DateFormat('d MMM').format(DateTime.now());
  String formattedTime = DateFormat('h:mm a').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat('d MMM yyyy').format(DateTime.now()),
          style: TextStyle(
              color: Colors.grey.shade700, fontWeight: FontWeight.w400),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 13, bottom: 13, right: 5, left: 5),
            child: Row(
              //
              children: [
                Column(
                  //
                  children: [
                    Container(
                      width: 125,
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
                  //
                  children: [
                    Container(
                      width: 125,
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
                      width: 125,
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
            //  width: double.maxFinite,
            height: 70,
            padding: EdgeInsets.only(left: 17, right: 5, top: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Final balance",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 170,
                ),
                Text(
                  "Rs.${DataBox.calculateCashInTotal() - DataBox.calculateCashOutTotal()} ",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              border: Border(
                top: BorderSide(width: 3.0, color: Colors.black),
                bottom: BorderSide(width: 2.0, color: Colors.green.shade800),
              ),
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
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          title: SizedBox(
                            width: 175,
                            child: Row(
                              children: [
                                Text(
                                    "${DateFormat('d MMM yy').format(transaction.entryDate)} . ${DateFormat('h:mm a').format(transaction.entryDate)}"),
                              ],
                            ),
                          ),
                          trailing: SizedBox(
                            width: 160,
                            child: Row(
                              children: [
                                Container(
                                  width: 85,
                                  child: Text(
                                    " ${transaction.cashIn}",
                                    style: TextStyle(
                                        fontSize: 20, color: Color(0xFF4CBB17)),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 1,
                                // ),
                                Container(
                                  width: 70,
                                  child: Text(
                                    " ${transaction.cashOut}",
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
          ),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            constraints: BoxConstraints(maxWidth: double.infinity),
            height: 100,
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
          )
        ],
      ),
    );
  }
}
