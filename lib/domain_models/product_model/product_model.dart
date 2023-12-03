import 'package:hive_flutter/hive_flutter.dart';
part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject{
  ProductModel({
   required this.name,
   required this.category,
   required this.id,
   required this.buyingPrice,
   required this.sellPrice,
   required this.minCount,
   required this.packageCount,
   required this.packageItemsCount,
   required this.count,
   required this.availableSale,
   required this.storingDate,
});
  @HiveField(0)
  String name;
  @HiveField(1)
  String category;
  @HiveField(2)
  String id;
  @HiveField(3)
  double buyingPrice;
  @HiveField(4)
  double sellPrice;
  @HiveField(5)
  double minCount;
  @HiveField(6)
  double packageItemsCount;
  @HiveField(7)
  double packageCount;
  @HiveField(8)
  double count;
  @HiveField(9)
  double availableSale;
  @HiveField(10)
  DateTime storingDate;
}