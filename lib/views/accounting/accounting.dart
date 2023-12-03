import 'package:accounting/data_cubites/accounting_cubit/accounting_cubit.dart';
import 'package:accounting/views/accounting/year.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain_models/fatorah_model/fatorah_model.dart';

class Accounting extends StatelessWidget {
  const Accounting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accountingCubit = BlocProvider.of<AccountingCubit>(context);
    List<FatorahModel> allOldOrders = accountingCubit.allOldOrders;
    int year = DateTime.now().year;
    int stoppedIndex = 0;
    List yearsNum = [];
    allOldOrders.forEach((element) {
      if (!yearsNum.contains(element.createdAt.year)) {
        yearsNum.add(element.createdAt.year);
      }
    });
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.all(30.sp),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
        ),
        itemCount: yearsNum.length,
        itemBuilder: (context, index) {
          int length = allOldOrders.length;
          List<FatorahModel> list = [];
          for (int i = stoppedIndex; i < length; i++) {
            if (allOldOrders[i].createdAt.year == year) {
              list.add(allOldOrders[i]);
            } else {
              stoppedIndex = i;
              year = allOldOrders[i].createdAt.year;
              break;
            }
          }
          return Year(
            yearOrders: list,
          );
        },
      ),
    );
  }
}
