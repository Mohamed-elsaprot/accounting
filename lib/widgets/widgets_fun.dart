import '../app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../domain_models/fatorah_model/fatorah_model.dart';

border() {
  return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.black,
      ),
      borderRadius: BorderRadius.circular(20));
}

dayFormat(DateTime dateTime) {
  return '${dateTime.day} / ${dateTime.month} / ${dateTime.year}';
}

timeFormat(DateTime dateTime) {
  return DateFormat().add_Hm().format(dateTime);
}

dayAndTime(DateTime dateTime) {
  int x= dateTime.hour;
  String mM='AM';
  if(x>12){
    mM='PM';
    x-=12;
  }
  return '${dateTime.day}/${dateTime.month}/${dateTime.year}   $x:${dateTime.minute} $mM';
}

num dayProfit(List<FatorahModel> list) {
  num total = 0;
  list.forEach((element) {
    total += element.fatorahTotal!;
  });
  return total;
}