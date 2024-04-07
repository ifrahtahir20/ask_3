import 'package:cashinout/CashBook/AddAmount.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data_record.dart';

class DataBox {
  static const String khata_record = "khata_record"; //definning box name
  static const String customer_supplier = "customersupplier";
  //=====INITIALIZATION WORK ..(start)
  static GetHiveFunction() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(KhataRecordAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(CustomerSupplierAdapter());
    }
    if (!Hive.isBoxOpen(khata_record)) {
      await Hive.openBox<KhataRecord>(khata_record);
    }
    if (!Hive.isBoxOpen(customer_supplier)) {
      await Hive.openBox<CustomerSupplier>(customer_supplier);
    }
  }

  //=====INITIALIZATION WORK ..(end)

  //=====Getting box for crud operation   ..(start)
  static Box<KhataRecord> DataRecordBox() {
    return Hive.box(khata_record);
  }

  static Box<CustomerSupplier> DataCSBox() {
    return Hive.box(customer_supplier);
  }

  // =====Getting box for crud operation   ..(end)
  static List<CustomerSupplier> addRecord(CustomerSupplier customerSupplier) {
    final box = DataCSBox();
    box.add(customerSupplier); // Using the key to store the customer/supplier
    final List<CustomerSupplier> records =
        box.values.toList(); // Get all records
    return records; // Return the updated list of records
  }

  static void AddRecord(CustomerSupplier customerSupplier) async {
    Box box_student = await DataCSBox();
    box_student.put(customerSupplier.key, customerSupplier);
  }

  static void updateRecord(int key, CustomerSupplier customerSupplier) {
    final box = DataCSBox();
    final record = box.get(key);
    if (record != null) {
      record.name = customerSupplier.name;
      record.phone_number = customerSupplier.phone_number;
      box.put(key, record);
    }
  }

  static int calculateTotalBalance() {
    int total = 0;
    for (var i = 0; i < DataRecordBox().length; i++) {
      final transaction = DataRecordBox().getAt(i)!;
      if (transaction.type == 'Cash In') {
        total += transaction.amount;
      } else {
        total -= transaction.amount;
      }
    }
    return total;
  }

  static int calculateCashInTotal() {
    int CashINTotal = 0;
    for (var i = 0; i < DataBox.DataRecordBox().length; i++) {
      var record = DataBox.DataRecordBox().getAt(i);
      if (record != null && record.type == 'Cash In') {
        CashINTotal += record.amount;
      }
    }
    return CashINTotal;
  }

  static int calculateCashOutTotal() {
    int CashOutTotal = 0;
    for (var i = 0; i < DataBox.DataRecordBox().length; i++) {
      var record = DataBox.DataRecordBox().getAt(i);
      if (record != null && record.type == 'Cash Out') {
        CashOutTotal += record.amount;
      }
    }
    return CashOutTotal;
  }

  static String GetNewKey() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static String GetCSKey() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
