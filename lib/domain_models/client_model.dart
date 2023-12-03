import 'package:accounting/domain_models/fatorah_model/fatorah_model.dart';


class ClientModel{
  ClientModel({
    required this.name,
    required this.phone,
    required this.clientOldOrders,
});
  String name,phone;
  FatorahModel clientOldOrders;
}