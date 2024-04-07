import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'AfterAmount.dart';
import '../HiveDatabase/data_box.dart';
import '../HiveDatabase/data_record.dart';
import 'update.dart';

class AddAmount extends StatefulWidget {
  final bool isCashIn;
  KhataRecord? dataRecord;
  AddAmount({required this.isCashIn, this.dataRecord});

  @override
  State<AddAmount> createState() => _AddAmountState();
}

class _AddAmountState extends State<AddAmount> {
  final _formKey = GlobalKey<FormState>();
  late bool isCashIn = true;
  late Box<KhataRecord> transactionBox;
  int CashInTotal = 0;
  int CashOutTotal = 0;
  int total_balance_cash = 0;
  final amountController = TextEditingController();
  String formattedDate = DateFormat('d MMM').format(DateTime.now());
  String formattedTime = DateFormat('h:mm a').format(DateTime.now());
  @override
  void initState() {
    super.initState();
    isCashIn = widget.isCashIn;
    setState(() {
      transactionBox = DataBox.DataRecordBox();
    });
    CashOutTotal = DataBox.calculateCashOutTotal();
    CashInTotal = DataBox.calculateCashInTotal();
    total_balance_cash = DataBox.calculateTotalBalance();
    if (widget.dataRecord != null) {
      setState(() {
        amountController.text = widget.dataRecord!.amount.toString();
      });
    }
  }

  int _addTransaction(String type) {
    final amount = int.parse(amountController.text.toString());
    final int previousTotalBalance = DataBox.calculateTotalBalance();
    if (widget.dataRecord != null) {
      final existingTransaction = widget.dataRecord!;
      final int previousAmount = existingTransaction.amount;
      final String previousType = existingTransaction.type;
      final int index = transactionBox.values
          .toList()
          .indexWhere((record) => record.key == existingTransaction.key);
      if (index != -1) {
        existingTransaction.amount = amount;
        existingTransaction.type = type;
        transactionBox.putAt(index, existingTransaction);
        if (previousType == 'Cash In') {
          total_balance_cash += (amount - previousAmount);
        } else {
          total_balance_cash -= (amount - previousAmount);
        }
      }
      if (type == 'Cash Out' && amount > total_balance_cash) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Cash out amount cannot exceed total balance.",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.red,
          ),
        );
        total_balance_cash = previousTotalBalance;
      }
    } else {
      final transaction = KhataRecord(type: type, amount: amount);
      transactionBox.add(transaction);
      if (type == 'Cash In') {
        CashInTotal += amount;
        total_balance_cash += amount;
      } else {
        CashInTotal += amount;
        if (type == 'Cash Out' && amount > total_balance_cash) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Cash out amount cannot exceed total balance.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.red,
            ),
          );
          //  total_balance_cash = previousTotalBalance;
        } else {
          total_balance_cash -= amount;
        }
      }
      // DataBox.calculateCashOutTotal();
      // DataBox.calculateCashInTotal();
    }
    setState(() {});
    amountController.clear();
    return total_balance_cash;
  }

  @override
  Widget build(BuildContext context) {
    String titleText = isCashIn ? 'Cash In' : 'Cash Out';
    String appBarTitle =
        "${(widget.dataRecord != null) ? "Edit Transaction " : "New Entry "}($titleText)";
    Color rsColor = isCashIn ? Color(0xFF4CBB17) : Colors.orange.shade800;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          automaticallyImplyLeading: true,
          title: Text(appBarTitle),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Balance: Rs.${total_balance_cash}",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 20, top: 10, bottom: 10),
                child: TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Enter cash Amount"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter cash amount';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    isCashIn
                        ? _addTransaction('Cash In')
                        : _addTransaction('Cash Out');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CashBookScreen(
                          //totalBalance: totalBalance,
                          selectedIndex: 1,
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 25, color: Colors.grey.shade400),
                ),
                style: TextButton.styleFrom(
                  side: BorderSide(width: 1, color: Colors.grey.shade400),
                  minimumSize: Size(270, 60),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
