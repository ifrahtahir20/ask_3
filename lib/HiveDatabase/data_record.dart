// import 'dart:typed_data';
//
// import 'package:hive/hive.dart';
// part 'data_record.g.dart';
//
// @HiveType(typeId: 0)
// class KhataRecord extends HiveObject {
//   @HiveField(1)
//   dynamic key;
//   @HiveField(2, defaultValue: 1)
//   double CashIn = 0.0;
//   @HiveField(3, defaultValue: 1)
//   double CashOut = 0.0;
//   @HiveField(4, defaultValue: 1)
//   double balance = 0.0;
//   // @HiveField(3, defaultValue: "")
//   // DateTime date = DateTime.now();
//   // @HiveField(4, defaultValue: "")
//   // DateTime time = DateTime.now();
// }
import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'data_record.g.dart';

@HiveType(typeId: 0)
class KhataRecord extends HiveObject {
  @HiveField(1)
  dynamic key;
  @HiveField(2, defaultValue: "")
  String type = "";
  @HiveField(3, defaultValue: 1)
  int amount = 0;
  int get cashIn => type == 'Cash In' ? amount : 0;
  int get cashOut => type == 'Cash Out' ? amount : 0;
  @HiveField(4)
  DateTime entryDate = DateTime.now();
  KhataRecord({required this.type, required this.amount}) {
    entryDate = DateTime.now();
  }
}

@HiveType(typeId: 1)
class CustomerSupplier extends HiveObject {
  @HiveField(0)
  dynamic key;
  @HiveField(1)
  String person_type = "";
  @HiveField(2)
  String name = "";
  @HiveField(3)
  int? phone_number;
  String get Customer => person_type == 'Customer' ? name : '';
  String get Supplier => person_type == 'Supplier' ? name : '';
  CustomerSupplier({
    required this.person_type,
    required this.name,
    this.phone_number,
  });
}
