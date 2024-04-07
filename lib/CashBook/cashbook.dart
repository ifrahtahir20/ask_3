import 'package:cashinout/CashBook/AddAmount.dart';
import 'package:flutter/material.dart';

import '../Customer/add_customer_supplier.dart';
import '../Customer/loginscreen.dart';

class CashBook extends StatefulWidget {
  final int selectedIndex;
  CashBook({
    required this.selectedIndex,
  });
  @override
  State<CashBook> createState() => _CashBookState();
}

class _CashBookState extends State<CashBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 10,
                    ),
                    child: Text(
                      " Cash in/ Cash out se Sales / Expenses maintain karen. Easy Items ka stock. free receipts. ",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Image.asset(
                      "assets/images/screen_image.png",
                      width: 300,
                      height: 220,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
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
          SizedBox(
            height: 20,
          ),
        ],
      ),
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
