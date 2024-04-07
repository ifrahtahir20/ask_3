// add_customer_supplier_screen.dart

import 'package:cashinout/Customer/afterrecord.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../HiveDatabase/data_box.dart';
import '../HiveDatabase/data_record.dart';
import 'loginscreen.dart';

class AddCustomerSupplierScreen extends StatefulWidget {
  final bool isCustomer;
  CustomerSupplier? customerSupplier;
  AddCustomerSupplierScreen({required this.isCustomer, this.customerSupplier});
  @override
  _AddCustomerSupplierScreenState createState() =>
      _AddCustomerSupplierScreenState();
}

class _AddCustomerSupplierScreenState extends State<AddCustomerSupplierScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phone_noController = TextEditingController();
  late String _name = '';
  late String _mobileNumber = '';
  late bool isCustomer = true;
  @override
  void initState() {
    isCustomer = widget.isCustomer;
    if (widget.customerSupplier != null) {
      nameController.text = widget.customerSupplier!.name;
      phone_noController.text =
          widget.customerSupplier!.phone_number.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    String titleText = isCustomer ? 'Customer' : 'Supplier';
    String appBarTitle =
        "${(widget.customerSupplier != null) ? "Update " : "Create "}$titleText";
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outlined,
                      size: 30,
                    ),
                    hintText: 'Enter $titleText Name',
                    labelText: '$titleText Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                onSaved: (value) {
                  _mobileNumber = value!;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                    size: 30,
                  ),
                  labelText: 'Mobile Number',
                  hintText: 'Enter Mobile Number (Optional)',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final customerSupplier = CustomerSupplier(
                      person_type: isCustomer ? 'Customer' : 'Supplier',
                      name: _name,
                      phone_number: int.tryParse(_mobileNumber) ?? 0,
                    );
                    DataBox.addRecord(customerSupplier);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Record saved successfully')),
                    );
                    nameController.clear();
                    phone_noController.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AfterRecord(),
                      ),
                    );
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
