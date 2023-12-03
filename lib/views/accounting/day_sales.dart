import 'package:accounting/data_cubites/accounting_cubit/accounting_cubit.dart';
import 'package:accounting/data_cubites/accounting_cubit/accounting_state.dart';
import 'package:accounting/views/accounting/order.dart';
import 'package:accounting/views/accounting/widgets/inventory_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain_models/fatorah_model/fatorah_model.dart';
import '../../widgets/home_button.dart';
import '../../widgets/widgets_fun.dart';

class DaySales extends StatelessWidget {
  const DaySales({Key? key, required this.day, required this.daySalesOrders})
      : super(key: key);
  final DateTime day;
  final List<FatorahModel> daySalesOrders;

  @override
  Widget build(BuildContext context) {
    var accountingCubit = BlocProvider.of<AccountingCubit>(context);
    double sell = 0, buy = 0, profit = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('${dayFormat(day)} مبيعات'),
        actions: [
          HomeButton(
            function: accountingCubit.dayGardFalse(),
          )
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 10,
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 10),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: daySalesOrders.length,
              itemBuilder: (context, index) => ListTile(
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${daySalesOrders[index].fatorahTotal}',
                      style: const TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
                title: Text(
                    '${daySalesOrders[index].createdAt.hour}:${daySalesOrders[index].createdAt.minute}',
                    style: TextStyle(fontSize: 22.sp)),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Order(
                            fatorah: daySalesOrders[index],
                            isDept: false,
                          )));
                  accountingCubit.dayGardFalse();
                },
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: BlocBuilder<AccountingCubit, AccountingState>(
                builder: (context, state) {
                  return InventoryColumn(
                      date: '${dayFormat(day)}',
                      gard: accountingCubit.dayGard,
                      buy: buy,
                      profit: profit,
                      sell: sell);
                },
              ))
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          accountingCubit.dayGard = !accountingCubit.dayGard;
          accountingCubit.emit(Gard());
          if (accountingCubit.dayGard) {
            Map gardMap = accountingCubit.gard(daySalesOrders);
            sell = gardMap['sell'];
            buy = gardMap['buy'];
            profit = gardMap['profit'];
          }
        },
        child: const Text('جرد'),
      ),
    );
  }
}
