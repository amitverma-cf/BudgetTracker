import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 1)
class Account extends HiveObject {
  @HiveField(0)
  String name = "Untitled";

  @HiveField(1)
  String imgUrl =
      "https://www.shareicon.net/data/2016/09/13/828808_card_512x512.png";

  @HiveField(3)
  double totalAmount = 0.0;
}
