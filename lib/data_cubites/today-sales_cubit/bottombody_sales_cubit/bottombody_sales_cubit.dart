import 'dart:developer';

import 'package:accounting/consts.dart';
import 'package:accounting/data_cubites/today-sales_cubit/bottombody_sales_cubit/bottombody_sales_state.dart';
import 'package:accounting/domain_models/best_sellers/best_seller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain_models/fatorah_model/fatorah_item_model/fatorah_item.dart';

class FatorahItemsCubit extends Cubit<FatorahItemsState> {
  FatorahItemsCubit() : super(FatorahItemsInitial());

  var bestSellerBox = Hive.box<BestSeller>(bestSeller);

  changeItemsList(List<FatorahModelItem> list) {
    emit(ChangeFatorahItemsList(itemsList: list));
  }

  addProductToBestSellersBox(List<FatorahModelItem> list) async{
    List namesAndCountList = [];
    list.forEach((element) {
      namesAndCountList.add(element.productName);
      namesAndCountList.add(element.count);
    });
    if (bestSellerBox.isNotEmpty) {
      if (bestSellerBox.getAt(bestSellerBox.length - 1)!.dateTime.month != DateTime.now().month) {
        await bestSellerBox.clear();
        for (int i = 0; i < namesAndCountList.length; i += 2) {
          bestSellerBox.add(BestSeller(name: namesAndCountList[i], count: namesAndCountList[i + 1], dateTime: DateTime.now()));
        }
      } else {
        for (int i = 0; i < namesAndCountList.length; i += 2) {
          bestSellerBox.add(BestSeller(name: namesAndCountList[i], count: namesAndCountList[i + 1], dateTime: DateTime.now()));
        }
      }
    } else {
      for (int i = 0; i < namesAndCountList.length; i += 2) {
        bestSellerBox.add(BestSeller(name: namesAndCountList[i], count: namesAndCountList[i + 1], dateTime: DateTime.now()));
      }
    }
    log('Best seller Box length${bestSellerBox.length}');
  }

  List<BestSeller> getBestSellers(){
    List<BestSeller> bestSellersList=[];
    List<String> names =[];

    BestSeller test=BestSeller(name: 'No product yet', count: 0, dateTime: DateTime.now());

    for(int i=0; i<bestSellerBox.length ; i++){
      if(!names.contains(bestSellerBox.getAt(i)!.name)){
        names.add(bestSellerBox.getAt(i)!.name);
        bestSellersList.add(BestSeller(name: bestSellerBox.getAt(i)!.name, count: 0, dateTime: DateTime.now()));
      }
    }
    for(int i=0; i<bestSellerBox.length; i++){
      for(int y=0; y<names.length; y++){
        if(names[y]==bestSellerBox.getAt(i)!.name){
          bestSellersList[y].count+= bestSellerBox.getAt(i)!.count;
        }
      }
    }
    for(int i=0;i<bestSellersList.length;i++){
      for(int j=1; j<bestSellersList.length-i; j++){
        if(bestSellersList[j-1].count < bestSellersList[j].count){
          test = bestSellersList[j-1];
          bestSellersList[j-1]=bestSellersList[j];
          bestSellersList[j]=test;
        }
      }
    }
    return bestSellersList;
  }
}

