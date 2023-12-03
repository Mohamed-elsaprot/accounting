import 'package:hive_flutter/hive_flutter.dart';

part 'best_seller.g.dart';
@HiveType(typeId: 4)
class BestSeller{
  BestSeller({
    required this.name,
    required this.count,
    required this.dateTime,
});
  @HiveField(0)
  String name;
  @HiveField(1)
  double count = 0;
  @HiveField(2)
  DateTime dateTime;
}