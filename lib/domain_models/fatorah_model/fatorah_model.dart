import 'package:hive_flutter/hive_flutter.dart';

import 'fatorah_item_model/fatorah_item.dart';

part 'fatorah_model.g.dart';

@HiveType(typeId:  1)
class FatorahModel extends HiveObject{
  FatorahModel( {
    required this.clientPhone,
    required this.createdAt,
    required this.fatorahProductsList,
    required this.clientName,
    required this.account,
    required this.fatorahTotal,
  });
  @HiveField(0)
  double fatorahTotal;
  @HiveField(1)
  DateTime createdAt;
  @HiveField(2)
  String? clientName;
  @HiveField(3)
  String? clientPhone;
  @HiveField(4)
  final String account;
  @HiveField(5)
  List<FatorahModelItem> fatorahProductsList =[];

}