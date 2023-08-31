// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecordAdapter extends TypeAdapter<Record> {
  @override
  final int typeId = 0;

  @override
  Record read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Record()
      ..account = fields[0] as String
      ..category = fields[1] as String
      ..notes = fields[2] as String
      ..amount = fields[3] as double
      ..time = fields[4] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Record obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.account)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.notes)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
