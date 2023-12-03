import 'package:accounting/consts.dart';
import 'package:accounting/data_cubites/accounting_cubit/accounting_state.dart';
import 'package:accounting/domain_models/expenses_model/expenses_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain_models/fatorah_model/fatorah_model.dart';
import '../../domain_models/product_model/product_model.dart';

class AccountingCubit extends Cubit<AccountingState> {
  AccountingCubit() : super(const AccountingInitial());

  List<FatorahModel> allOldOrders = [];
  List<FatorahModel> deptList = [];
  List<FatorahModel> deptSearchList = [];
  List<ExpensesModel> expensesList = [];
  List<ExpensesModel> expensesSearchList = [];
  var box = Hive.box<FatorahModel>(fatorahBox);
  var deptBox = Hive.box<FatorahModel>(deptsBox);
  var exBox = Hive.box<ExpensesModel>(expensesBox);

  bool yearGard = false;
  bool monthGard = false;
  bool dayGard = false;

  getAllOrdersAndExpensesListFromHive()async {
    if(box.length!=0){
      for(int i=box.length-1 ; i>=0 ; i--){
        allOldOrders.add(box.getAt(i)!);
      }
    }
    if(deptBox.length!=0){
      for(int i=deptBox.length-1 ; i>=0 ; i--){
        deptList.add(deptBox.getAt(i)!);
      }
    }
    if(exBox.length!=0){
      for(int i= exBox.length-1 ; i>=0 ; i--){
        expensesList.add(exBox.getAt(i)!);
      }
    }
    expensesSearchList=expensesList;
    deptSearchList=deptList;
  }

  addExpenses(ExpensesModel expensesModel){
    exBox.add(expensesModel);
    expensesList.insert(0, expensesModel);
  }

  calcExpenses(){
    double total=0;
    expensesSearchList.forEach((element)=> total+=element.amountOfMoney);
    return total;
  }

  calcDept(){
    double total=0;
    deptSearchList.forEach((element)=> total+=element.fatorahTotal);
    return total;
  }

  upDateExpensesSearchList(String searchType, key){
    if(searchType=='date'){
      if(key.isNotEmpty){
        expensesSearchList = expensesList.where((element) {
          int hour=element.dateTime.hour;
          if(element.dateTime.hour>12){
            hour-=12;
          }
          String date = '${element.dateTime.day}/${element.dateTime.month}/${element.dateTime.year} $hour:${element.dateTime.minute}';
          return date.contains(key);
        }).toList();
      }else{
        expensesSearchList=expensesList;
      }
    }else{
      if(key.isNotEmpty){
        expensesSearchList = expensesList.where((element) => element.title.contains(key)).toList();
      }else{
        expensesSearchList=expensesList;
      }
    }
    emit(ExpensesSearch());
  }

  upDateDeptSearchList(String searchType, key){
    if(searchType=='date'){
      if(key.isNotEmpty){
        deptSearchList = deptList.where((element) {
          int hour=element.createdAt.hour;
          if(element.createdAt.hour>12){
            hour-=12;
          }
          String date = '${element.createdAt.day}/${element.createdAt.month}/${element.createdAt.year} $hour:${element.createdAt.minute}';
          return date.contains(key);
        }).toList();
      }else{
        deptSearchList=deptList;
      }
    }else{
      if(key.isNotEmpty){
        deptSearchList = deptList.where((element) => element.clientName!.contains(key)).toList();
      }else{
        deptSearchList=deptList;
      }
    }
    emit(DeptSearch());
  }

  returned(FatorahModel fatorah,List<ProductModel> allProductsList)async{
    List products=[];
    var prBox = Hive.box<ProductModel>(productsBox);

    fatorah.fatorahProductsList.forEach((element) {
      products.add({'name':element.productName,'count':element.count});
    });
    for(int i=0;i<products.length;i++){
      int index= allProductsList.indexWhere((element) => element.name==products[i]['name']);
      allProductsList[index].count+=products[i]['count'];
      prBox.putAt(index, allProductsList[index]);
    }
    allOldOrders.remove(fatorah);
    for(int i=0;i<box.length;i++){
      if(box.getAt(i)==fatorah){
        await box.deleteAt(i);
      }
    }
  }
//------------------------------------------------------------
  gard(List<FatorahModel> list){
    double buy=0, sell=0, profit=0;
    list.forEach((fatorah) {
      sell+=fatorah.fatorahTotal;
      fatorah.fatorahProductsList.forEach((item) {
        buy+= item.productBuyingPrice * item.count;
      });
    });
    profit = sell - buy;
    return {'buy':buy,'sell':sell,'profit':profit};
  }

  addNewOrder(FatorahModel fatorahModel)async{
    allOldOrders.insert(0, fatorahModel);
    await box.add(fatorahModel);
  }

  addNewOrderToDept(FatorahModel fatorahModel,){
    deptList.insert(0, fatorahModel);
    deptBox.add(fatorahModel);
  }

//-------------------------------------

  yearGardFalse(){
    yearGard = false;
    emit(Gard());
  }
  monthGardFalse(){
    monthGard = false;
    emit(Gard());
  }
  dayGardFalse(){
    dayGard = false;
    emit(Gard());
  }
}