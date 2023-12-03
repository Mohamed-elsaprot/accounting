import 'package:accounting/app/app_colors.dart';
import 'package:accounting/data_cubites/accounting_cubit/accounting_cubit.dart';
import 'package:accounting/data_cubites/accounting_cubit/accounting_state.dart';
import 'package:accounting/widgets/custom_textfield.dart';
import 'package:accounting/widgets/widgets_fun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Expenses extends StatelessWidget {
  const Expenses({Key? key,}) : super(key: key);

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
                            accountingCubit.upDateExpensesSearchList('date', x),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      flex: 3,
                      child: CustomTextField(
                        title: 'العنوان',
                        onChange: (x) => accountingCubit.upDateExpensesSearchList('title', x!),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                        flex: 2,
                        child: ElevatedButton(
                      onPressed: (){
                        showDialog(context: context, builder:(context)=> AlertDialog(
                          title: Text(' اجمالي المصاريف:  ${accountingCubit.calcExpenses()}'),
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
                    itemCount: accountingCubit.expensesSearchList.length,
                    separatorBuilder: (context, index) => const Divider(
                      indent: 30,
                      endIndent: 30,
                    ),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 20.sp, color: AppColors.black),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(dayAndTime(accountingCubit
                                  .expensesSearchList[index].dateTime)),
                              Text(accountingCubit
                                  .expensesSearchList[index].title),
                              Text(
                                  '${accountingCubit.expensesSearchList[index].amountOfMoney}  EGP'),
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
