import 'package:cashinout/CashBook/AddAmount.dart';
import 'package:cashinout/HiveDatabase/data_box.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../HiveDatabase/data_record.dart';

class UpDel extends StatefulWidget {
  final KhataRecord record;

  final Function onLoad;
  final int index;
  const UpDel({
    required this.index,
    required this.record,
    required this.onLoad,
  });

  @override
  State<UpDel> createState() => _UpDelState();
}

class _UpDelState extends State<UpDel> {
  late KhataRecord _record;
  late Box<KhataRecord> transactionBox;
  @override
  void initState() {
    super.initState();
    _record = widget.record;
  }

  void deleteRecord() {
    try {
      DataBox.DataRecordBox().delete(_record.key);
      widget.onLoad();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.grey,
        content: Text("Record deleted successfully."),
      ));
      setState(() {
        print("listview updated");
      });
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error deleting record: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void updateRecord() async {
    if (_record.type == "Cash In") {
      widget.onLoad();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddAmount(
                  isCashIn: true,
                  dataRecord: _record,
                )),
      );
      setState(() {});
      DataBox.calculateCashOutTotal();
      DataBox.calculateCashInTotal();
    } else {
      widget.onLoad();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddAmount(
                  isCashIn: false,
                  dataRecord: _record,
                )),
      );
      setState(() {});
      DataBox.calculateCashOutTotal();
      DataBox.calculateCashInTotal();
    }
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
            title: SizedBox(
                child: Row(
              children: [
                Text('Details'),
                SizedBox(
                  width: 150,
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            "Transaction delete",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.black),
                          ),
                          content: Text(
                            "Kia aap ye transaction khatam karna chahte hain?",
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                deleteRecord();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(135, 50),
                                // backgroundColor: Colors.white70,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                "No",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(135, 50),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },

                  //deleteRecord,
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                  iconSize: 38,
                )
              ],
            ))),
        body: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: DataBox.DataRecordBox().listenable(),
                  builder: (context, box, _) {
                    final records = box.values.toList();
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                title: Text('Rs. ${_record.amount}'),
                                subtitle: Text(' ${_record.type}'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.calendar_today_outlined),
                                title: SizedBox(
                                  width: 175,
                                  child: Row(
                                    children: [
                                      // if (widget.formattedDate != null)
                                      //   Text('${widget.formattedDate!} . '),
                                      // if (widget.formattedTime != null)
                                      //   Text('${widget.formattedTime!}'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 100,
          child: BottomAppBar(
            child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: updateRecord,
                    child: Text(
                      "Edit",
                      style: TextStyle(fontSize: 20, color: Colors.white),
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
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Add Customer',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      minimumSize: Size(150, 60),
                      backgroundColor: Color(0xFF4CBB17),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
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
