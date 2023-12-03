import 'package:accounting/data_cubites/today-sales_cubit/topbody_sales_cubit/topbody_sales_state.dart';
import 'package:accounting/domain_models/product_model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain_models/fatorah_model/fatorah_item_model/fatorah_item.dart';
import '../../../domain_models/fatorah_model/fatorah_model.dart';

class TopBodySalesCubit extends Cubit<TopBodySalesState> {
  TopBodySalesCubit() : super(TopBodySalesInitial());
  FatorahModel? fatorahModel;
  List<FatorahModelItem> fatorahItemsList = [];
  String? clientPhone = 'No Number', clientName = 'No Name', account;
  double fatorahTotal = 0, manualSale = 0, availableSale = 0, percentageSale =0, fatorahTotalSale=0;
  DateTime? createdAt;
  double? count, itemTotalPrice;
  ProductModel? product;
  List<Map<String, double>> fatorahProductsListIdAndCount = [];
  bool sale = false;


  resetData() {
    product = null;
    sale = false;
    availableSale = 0;
    manualSale=0;
    emit(TopBodySalesInitial());
  }

  addToProductsList(ProductModel productModel) {
    fatorahProductsListIdAndCount.insert(0, {productModel.id: count!});
  }


  setAvailableSale(bool x) {
    sale = x;
    availableSale = sale? product?.availableSale ?? 0 : 0;
    emit(TopBodySalesInitial());
    checkProduct();
  }

  checkProduct() {
    if (product != null) {
      emit(const ProductNotNull());
    } else {
      emit(TopBodySalesInitial());
    }
  }

  addFatorahItem({
    required String productName,
    required double productPrice,
    required double count,
    required double productBuyingPrice,
  }) {
    double totalSale = count * availableSale + manualSale;
    fatorahTotalSale+= totalSale;
    double itemTotalPrice = count * productPrice - totalSale;
    fatorahItemsList.insert(
        0,
        FatorahModelItem(
            productBuyingPrice: productBuyingPrice,
            itemTotalPrice: itemTotalPrice,
            productName: productName,
            count: count,
            productPrice: productPrice),
    );
  }

  calcFatorahTotal(List<FatorahModelItem> list) {
    double fatorahTotal = 0;
    fatorahItemsList.forEach((element) {
      fatorahTotal += element.itemTotalPrice;
    });
    fatorahTotalSale+=fatorahTotal*(percentageSale/100);
    fatorahTotal-= fatorahTotal*(percentageSale/100);
    return fatorahTotal;
  }

  setFatorah(){
    fatorahModel=FatorahModel(clientPhone: clientPhone, createdAt: DateTime.now(), fatorahProductsList: fatorahItemsList, clientName: clientName, account: 'account', fatorahTotal: calcFatorahTotal(fatorahItemsList));
  }
  printFatorahAndSave() {
    fatorahTotalSale=0;
    clientPhone = 'No Number'; clientName = 'No Name';
    fatorahProductsListIdAndCount = [];
    fatorahItemsList = [];
  }

}
