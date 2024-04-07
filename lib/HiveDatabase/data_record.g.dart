// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KhataRecordAdapter extends TypeAdapter<KhataRecord> {
  @override
  final int typeId = 0;

  @override
  KhataRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KhataRecord(
      type: fields[2] == null ? '' : fields[2] as String,
      amount: fields[3] == null ? 1 : fields[3] as int,
    )..key = fields[1] as dynamic;
  }

  @override
  void write(BinaryWriter writer, KhataRecord obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.key)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KhataRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CustomerSupplierAdapter extends TypeAdapter<CustomerSupplier> {
  @override
  final int typeId = 1;

  @override
  CustomerSupplier read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerSupplier(
      person_type: fields[1] as String,
      name: fields[2] as String,
      phone_number: fields[3] as int?,
    )..key = fields[0] as dynamic;
  }

  @override
  void write(BinaryWriter writer, CustomerSupplier obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.person_type)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.phone_number);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerSupplierAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
