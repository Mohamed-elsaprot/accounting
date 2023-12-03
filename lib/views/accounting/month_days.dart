import 'package:accounting/data_cubites/accounting_cubit/accounting_cubit.dart';
import 'package:accounting/views/accounting/day_sales.dart';
import 'package:accounting/views/accounting/widgets/inventory_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data_cubites/accounting_cubit/accounting_state.dart';
import '../../domain_models/fatorah_model/fatorah_model.dart';
import '../../widgets/home_button.dart';
import '../../widgets/widgets_fun.dart';

class MonthDays extends StatelessWidget {
  const MonthDays({Key? key, required this.dayOrders, required this.month, }) : super(key: key);
  final List<FatorahModel> dayOrders;
  final String month;
  @override
  Widget build(BuildContext context) {
    double sell=0,buy=0,profit=0;
    var accountingCubit= BlocProvider.of<AccountingCubit>(context);
    List<int> dayNum=[];
    dayOrders.forEach((element) {
      if(!dayNum.contains(element.createdAt.day)) dayNum.add(element.createdAt.day);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(month),
        actions: [HomeButton(function: accountingCubit.monthGardFalse(),)],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 10,
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 10),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: dayNum.length,
              itemBuilder: (context, index) {
                List<FatorahModel> orders = dayOrders.where((element) => element.createdAt.day == dayNum[index]).toList();
                return ListTile(
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${dayProfit(orders)} EGP', style: const TextStyle(color: Colors.black),),
                    SizedBox(width: 20.w,),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
                title: Text('${dayNum[index]} / $month',style: TextStyle(fontSize: 22.sp),),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DaySales(day: dayOrders[index].createdAt, daySalesOrders: orders,),),);
                  accountingCubit.monthGardFalse();
                },
              );
              },
            ),
          ),
          Expanded(flex: 3, child: BlocBuilder<AccountingCubit,AccountingState>(builder: (context,state){
            return InventoryColumn(date: month, gard: accountingCubit.monthGard,sell: sell,buy: buy,profit: profit,);
          },))
        ],
      ),
      floatingActionButton:ElevatedButton(
        onPressed: () {
          accountingCubit.monthGard= !accountingCubit.monthGard;
          accountingCubit.emit(Gard());
          if(accountingCubit.monthGard){
            Map gardMap = accountingCubit.gard(dayOrders);
            sell = gardMap['sell'];
            buy = gardMap['buy'];
            profit = gardMap['profit'];
          }
        },
        child:  const Text('جرد'),
      ),
    );
  }
}


