import 'package:cashinout/CashBook/AfterAmount.dart';
import 'package:cashinout/Customer/add_customer_supplier.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../HiveDatabase/data_box.dart';
import '../HiveDatabase/data_record.dart';
import 'customer_detail.dart';

class AfterRecord extends StatefulWidget {
  // final bool isCustomer;
  // AfterRecord({required this.isCustomer});
  @override
  State<AfterRecord> createState() => _AfterRecordState();
}

class _AfterRecordState extends State<AfterRecord> {
  PageController _pageController = PageController(initialPage: 0);
  double _dividerPosition = 0.0; // Initial position of the divider
  GlobalKey _customerKey = GlobalKey();
  GlobalKey _supplierKey = GlobalKey();
  GlobalKey _communityKey = GlobalKey();
  int _selectedIndex = 0;
  late CustomerSupplier _record;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // _record = widget.csrecord;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CashBookScreen(selectedIndex: index)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: () {
            addnew();
          },
          child: Column(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Text(
                        'Udhaar Book',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 110,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Icon(
                              Icons.backup_outlined,
                              size: 20,
                              color: Colors.red,
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Backup',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 100,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "My business",
                    style: TextStyle(fontSize: 17),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 17,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 5, right: 10, left: 10),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildOptionButton('Customer', 0, _customerKey),
                        buildOptionButton('Supplier', 1, _supplierKey),
                        buildOptionButton('Community', 2, _communityKey),
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
                      thickness: 5,
                      color: Colors.black,
                      indent: _dividerPosition,
                      endIndent: 0.0,
                    ),
                  ),
                  SizedBox(
                    height: 575,
                    // width: double.infinity,
                    // //  height: MediaQuery.of(context).size.height * 0.5,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _dividerPosition =
                              index * MediaQuery.of(context).size.width / 3;
                        });
                      },
                      children: [
                        buildScreen('Customer'),
                        buildScreen('Supplier'),
                        // CommunityScreen(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void addnew() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Aapke Businesses',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 150,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close)),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      thickness: 1.0,
                    ),
                  ],
                ),
                ListTile(
                  leading: Icon(Icons.business_sharp),
                  title: Text('Karobar ka naam'),
                  subtitle: Text('0 Total Customers'),
                  trailing: SizedBox(
                    width: 145,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Profile()));
                          },
                          icon: Icon(
                            Icons.edit_outlined,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Container(
                              //  padding: EdgeInsets.only(right: 3),
                              alignment: Alignment.center,
                              width: 30,
                              height: 30,
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                weight: 800,
                                size: 20,
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFF4CBB17),
                                  borderRadius: BorderRadius.circular(30)),
                            )),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.shade400,
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "CREATE NEW BUSINESS",
                    style: TextStyle(fontSize: 20, color: Colors.white70),
                  ),
                  style: TextButton.styleFrom(
                    minimumSize: Size(270, 60),
                    backgroundColor: Color(0xFF4CBB17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
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
        // padding: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.only(right: 25, left: 5),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }

  Widget buildScreen(String type) {
    final records =
        DataBox.DataCSBox().values.toList().cast<CustomerSupplier>();

    if (type == 'Customer') {
      final customerRecords =
          records.where((record) => record.person_type == 'Customer').toList();
      return CustomerScreen(
        buttonText: 'Add Customer',
        description:
            'Customer add karein aur khata maintain karen. Free payment reminder. Wasooli 3x tez.',
        isCustomer: true,
        records: customerRecords,
      );
    } else {
      final supplierRecords =
          records.where((record) => record.person_type == 'Supplier').toList();
      return CustomerScreen(
        buttonText: 'Add Supplier',
        description:
            'Supplier add karein aur purchasing maintain karen. Free payment reminder. Wasooli 3x tez.',
        isCustomer: false,
        records: supplierRecords,
      );
    }
  }
}

class CustomerScreen extends StatelessWidget {
  final String buttonText;
  final String description;
  final bool isCustomer;
  final List<CustomerSupplier> records;

  const CustomerScreen({
    Key? key,
    required this.buttonText,
    required this.description,
    required this.isCustomer,
    required this.records,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 175,
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Rs.",
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
                    width: 175,
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Rs.",
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
            ],
          ),
        ),
        Expanded(
          child: ValueListenableBuilder<Box<CustomerSupplier>>(
              valueListenable: DataBox.DataCSBox().listenable(),
              builder: (context, box, _) {
                List<CustomerSupplier> list =
                    box.values.toList().cast<CustomerSupplier>();
                // final records = box.values.toList().reversed.toList();
                return ListView.builder(
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    final CustomerSupplier transaction =
                        records[index] as CustomerSupplier;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Customer_Detail()),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          leading: Container(
                            padding: EdgeInsets.only(right: 3),
                            alignment: Alignment.center,
                            width: 30,
                            height: 30,
                            child: Text(
                                transaction.name.isNotEmpty
                                    ? transaction.name[0].toUpperCase()
                                    : '',
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
                          title: SizedBox(
                            width: 175,
                            child: Row(
                              children: [
                                Text('${transaction.name}'),
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
                                    '',
                                    style: TextStyle(
                                        fontSize: 20, color: Color(0xFF4CBB17)),
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  child: Text(
                                    '',
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
        // SizedBox(height: 70),
        Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          // constraints: BoxConstraints(maxWidth: double.infinity),
          //width: 800,
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
                      builder: (context) => AddCustomerSupplierScreen(
                        isCustomer: isCustomer,
                      ),
                    ),
                  );
                },
                child: Text(
                  buttonText,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  minimumSize: Size(270, 60),
                  backgroundColor: Color(0xFF4CBB17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
