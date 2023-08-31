import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 2)
class Category extends HiveObject {
  @HiveField(0)
  String name = "Untitled";

  @HiveField(1)
  String imgUrl = "https://img.lovepik.com/element/40068/1766.png_1200.png";
}
