import 'package:hive/hive.dart';

part 'record.g.dart';

@HiveType(typeId: 3)
enum RecordType {
  @HiveField(0)
  expense,

  @HiveField(1)
  income,

  @HiveField(2)
  transfer,
}

@HiveType(typeId: 0)
class Record extends HiveObject {
  @HiveField(0)
  late String account;

  @HiveField(1)
  late String category;

  @HiveField(2)
  String notes = "";

  @HiveField(3)
  double amount = 0.0;

  @HiveField(4)
  DateTime time = DateTime.now();

  @HiveField(5)
  RecordType type = RecordType.expense;
}
