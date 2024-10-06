import 'package:hive/hive.dart';

part 'item.g.dart'; // This is necessary for generating the adapter

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(2)
  String brand;

  @HiveField(3)
  String categoriesText;

  @HiveField(4)
  String ingredients;

  @HiveField(5)
  String image_url;

  @HiveField(6)
  List<String> getPackagingTextList;

  @HiveField(7)
  String ecoscore;

  @HiveField(8)
  Map<String, dynamic> nutriments;

  @HiveField(9)
  String nutriscore;

  @HiveField(10)
  String barcode;

  Item(
      this.name,
      this.brand,
      this.categoriesText,
      this.ecoscore,
      this.getPackagingTextList,
      this.image_url,
      this.ingredients,
      this.nutriments,
      this.nutriscore,
      this.barcode);
}
