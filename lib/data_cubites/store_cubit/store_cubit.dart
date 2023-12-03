import 'package:accounting/consts.dart';
import 'package:accounting/data_cubites/store_cubit/store_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain_models/product_model/product_model.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(const StoreInitial());

  List<ProductModel> allProductsList = [];
  List<ProductModel> searchProductsList = [];
  var allProductsBox = Hive.box<ProductModel>(productsBox);
  String? title;
  double amountOfMoney = 0;

   getProductsFromHive()async {
    if (allProductsBox.isNotEmpty) {
      for (int i = 0; i < allProductsBox.length; i++) {
        allProductsList.add(allProductsBox.getAt(i)!);
      }
    }
    searchProductsList = allProductsList;
  }

  List getOutOfStockProduct(){
    List<String> outOfStockProduct=[];
    allProductsList.forEach((element) {
      if(element.count==0||element.minCount==element.count){
        outOfStockProduct.add(element.name);
      }
    });
    return outOfStockProduct;
  }

  void updateSearchProductsSearchList(String x, String searchBy) {
    if (searchBy == 'name') {
      if (x.isNotEmpty) {
        searchProductsList = allProductsList.where((element) => element.name!.contains(x)).toList();
      } else {
        searchProductsList = allProductsList;
      }
    } else if (searchBy == 'category') {
      if (x.isNotEmpty) {
        searchProductsList = allProductsList
            .where((element) => element.category!.contains(x))
            .toList();
      } else {
        searchProductsList = allProductsList;
      }
    } else if (searchBy == 'id') {
      if (x.isNotEmpty) {
        searchProductsList =
            allProductsList.where((element) => element.id!.contains(x)).toList();
      } else {
        searchProductsList = allProductsList;
      }
    }
    emit(UpdateSearchList());
  }

  void addNewProduct(
      String name,
      String id,
      String category,
      double buyingPrice,
      double sellPrice,
      double gomlaPrice,
      double packageCount,
      double packageItemsCount,
      double count,
      double availableSale,
      DateTime dateTime) {
    var newProduct= ProductModel(
      name: name,
      id: id,
      category: category,
      buyingPrice: buyingPrice,
      sellPrice: sellPrice,
      minCount: gomlaPrice,
      availableSale: availableSale,
      storingDate: DateTime.now(),
      count: count,
      packageCount: packageCount,
      packageItemsCount: packageItemsCount,
    );
    allProductsList.add(newProduct);
    allProductsBox.add(newProduct);
    emit(AddNewProduct());
  }



  updateProduct({
    required String currentId,
    required String name,
    required String id,
    required String category,
    required double buyingPrice,
    required double sellPrice,
    required double gomlaPrice,
    required double packageCount,
    required double packageItemsCount,
    required double count,
    required double availableSale,
    required DateTime dateTime,
  }) async{
    int index = allProductsList.indexWhere((element) => element.id == currentId);
    allProductsList[index] = ProductModel(
      name: name,
      id: id,
      category: category,
      buyingPrice: buyingPrice,
      sellPrice: sellPrice,
      minCount: gomlaPrice,
      storingDate: dateTime,
      count: count,
      availableSale: availableSale,
      packageItemsCount: packageItemsCount,
      packageCount: packageCount,
    );
    await allProductsBox.putAt(index, allProductsList[index]);
    searchProductsList = allProductsList;
    emit(UpdateProduct());
  }

  upDateProductsCount(List<Map<String, double>> list) {
    list.forEach((element) {
      element.forEach((id, value) {
        var index = allProductsList.indexWhere((element) => element.id == id);
        allProductsList[index].count -= value;
        allProductsList[index].packageCount = (allProductsList[index].count / allProductsList[index].packageItemsCount).floorToDouble();
        allProductsBox.putAt(index, allProductsList[index]);
      });
    });
    emit(ChangeProductsCount());
  }

  updateAllPrices(double inc)async{
     searchProductsList.forEach((element) async {
       int index = allProductsList.indexWhere((x) => element.id == x.id);
       ProductModel product= allProductsList[index];
       product.sellPrice+= product.sellPrice*(inc/100);
       product.buyingPrice+= product.buyingPrice*(inc/100);
       await allProductsBox.putAt(index, allProductsList[index]);
     });
     searchProductsList = allProductsList;
     emit(UpdateProduct());
  }

  Future deleteProduct(String id) async {
    int index = allProductsList.indexWhere((element) => element.id == id);
    allProductsList.removeAt(index);
    await allProductsBox.deleteAt(index);
    searchProductsList = allProductsList;
    emit(DeleteProduct());
  }

  List<String> productsNamesList() {
    List<String> productsNames = [];
    allProductsList.forEach((element) => productsNames.add(element.name!));
    return productsNames;
  }

  List<String> productsIdList() {
    List<String> idList = [];
    allProductsList.forEach((element) => idList.add(element.id!));
    return idList;
  }
}
