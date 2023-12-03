import 'package:accounting/domain_models/fatorah_model/fatorah_model.dart';
import 'package:accounting/views/accounting/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/app_colors.dart';
import '../../data_cubites/accounting_cubit/accounting_cubit.dart';
import '../../data_cubites/accounting_cubit/accounting_state.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/widgets_fun.dart';

class DeptOrders extends StatelessWidget {
  const DeptOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var accountingCubit = BlocProvider.of<AccountingCubit>(context);
    if (size.width < 520 || size.height < 145) {
      return const Text('حجم الشاشه غير مناسب');
    } else {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              const SizedBox(height: 5,),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomTextField(
                        title: 'التاريخ',
                        onChange: (x) =>
                            accountingCubit.upDateDeptSearchList('date', x),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      flex: 3,
                      child: CustomTextField(
                        title: 'الاسم',
                        onChange: (x) => accountingCubit.upDateDeptSearchList('title', x!),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: (){
                            showDialog(context: context, builder:(context)=> AlertDialog(
                              title: Text(' اجمالي :  ${accountingCubit.calcDept()}'),
                              actions: [ElevatedButton(onPressed: ()=>Navigator.pop(context), child: const Text('اغلاق'))],
                            ));
                          },
                          child: const Text('جمع المصروفات'),
                        ))
                  ],
                ),
              ),
              Expanded(
                flex: 16,
                child: BlocBuilder<AccountingCubit, AccountingState>(
                    builder: (context, state) {
                      return ListView.separated(
                        itemCount: accountingCubit.deptSearchList.length,
                        separatorBuilder: (context, index) => const Divider(
                          indent: 30,
                          endIndent: 30,
                        ),
                        itemBuilder: (context, index) {
                          FatorahModel x= accountingCubit.deptSearchList[index];
                          return ListTile(
                            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Order(fatorah: x,isDept: true,))),
                            title: DefaultTextStyle(
                              style: TextStyle(fontSize: 20.sp, color: AppColors.black),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(dayAndTime(x.createdAt)),
                                  Text(x.clientName.toString()),
                                  Text('${x.fatorahTotal} EGP'),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    }
  }
}
