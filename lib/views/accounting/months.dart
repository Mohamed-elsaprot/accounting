import 'package:accounting/app/app_colors.dart';
import 'package:accounting/data_cubites/accounting_cubit/accounting_cubit.dart';
import 'package:accounting/data_cubites/accounting_cubit/accounting_state.dart';
import 'package:accounting/views/accounting/month_days.dart';
import 'package:accounting/views/accounting/widgets/year_inventory_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain_models/fatorah_model/fatorah_model.dart';

class Months extends StatelessWidget {
   const Months({Key? key, required this.monOrders, required this.year}) : super(key: key);
   final List<FatorahModel> monOrders;
   final String year;

  @override
  Widget build(BuildContext context) {
    double sell=0,buy=0,profit=0;
    var accountingCubit= BlocProvider.of<AccountingCubit>(context);
    List<int> monthsNum=[];
    monOrders.forEach((element) {
      if(!monthsNum.contains(element.createdAt.month)) monthsNum.add(element.createdAt.month);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(year),
        leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){
          Navigator.pop(context);
          accountingCubit.yearGardFalse();
        },),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: GridView.builder(
              padding: const EdgeInsets.all(30),
              itemCount: monthsNum.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  accountingCubit.yearGardFalse();
                  List<FatorahModel> monthOrders = monOrders.where((element) => element.createdAt.month == monthsNum[index]).toList();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MonthDays(dayOrders: monthOrders, month: '${monthsNum[index]} / $year',)));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(35)),
                  alignment: Alignment.center,
                  child: Text('${monthsNum[index]}',style: TextStyle(fontSize: 35.sp,color: AppColors.white),),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: BlocBuilder<AccountingCubit,AccountingState>(builder: (context,state){
              return YearInventoryContainer(gard: accountingCubit.yearGard,buy: buy,sell: sell,profit: profit,);
            }),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.all(25.sp)
        ),
        onPressed: () {
          accountingCubit.yearGard= !accountingCubit.yearGard;
          accountingCubit.emit(Gard());
          if(accountingCubit.yearGard){
            Map gardMap = accountingCubit.gard(monOrders);
            sell = gardMap['sell'];
            buy = gardMap['buy'];
            profit = gardMap['profit'];
          }
        },
        child: Text('جرد',style: TextStyle(fontSize: 22.sp),),
      ),
    );
  }
}
