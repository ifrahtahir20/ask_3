import 'package:flutter/material.dart';

class Customer_Detail extends StatefulWidget {
  const Customer_Detail({Key? key}) : super(key: key);

  @override
  State<Customer_Detail> createState() => _Customer_DetailState();
}

class _Customer_DetailState extends State<Customer_Detail> {
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
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: 3),
              alignment: Alignment.center,
              width: 30,
              height: 30,
              child: Text('',
                  // transaction.name.isNotEmpty
                  //     ? transaction.name[0].toUpperCase()
                  //     : '',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400)),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text('name'),
          ],
        ),
      ),
    );
  }
}
