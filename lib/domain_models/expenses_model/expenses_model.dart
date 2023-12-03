import 'package:hive_flutter/hive_flutter.dart';
part 'expenses_model.g.dart';
@HiveType(typeId: 3)
class ExpensesModel extends HiveObject{
  ExpensesModel({
    required this.title,
    required this.amountOfMoney,
    required this.dateTime,
});
  @HiveField(0)
  final String title;
  @HiveField(1)
  final double amountOfMoney;
  @HiveField(2)
  final DateTime dateTime;
}