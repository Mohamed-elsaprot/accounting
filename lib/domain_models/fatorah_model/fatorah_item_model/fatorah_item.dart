import 'package:hive_flutter/hive_flutter.dart';
part 'fatorah_item.g.dart';

@HiveType(typeId: 2)
class FatorahModelItem extends HiveObject{
  FatorahModelItem({
    required this.itemTotalPrice,
    required this.productName,
    required this.count,
    required this.productPrice,
    required this.productBuyingPrice,
  });

  @HiveField(0)
  String? productName;
  @HiveField(1)
  double productPrice;
  @HiveField(2)
  double count;
  @HiveField(3)
  double itemTotalPrice;
  @HiveField(4)
  double productBuyingPrice;
}