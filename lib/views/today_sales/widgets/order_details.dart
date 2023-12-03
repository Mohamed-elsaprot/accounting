
import 'package:accounting/app/func.dart';
import 'package:accounting/data_cubites/accounting_cubit/accounting_cubit.dart';
import 'package:accounting/data_cubites/store_cubit/store_cubit.dart';
import 'package:accounting/data_cubites/today-sales_cubit/bottombody_sales_cubit/bottombody_sales_cubit.dart';
import 'package:accounting/data_cubites/today-sales_cubit/bottombody_sales_cubit/bottombody_sales_state.dart';
import 'package:accounting/data_cubites/today-sales_cubit/topbody_sales_cubit/topbody_sales_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/app_colors.dart';
import '../../../data_cubites/today-sales_cubit/topbody_sales_cubit/topbody_sales_cubit.dart';
import 'add_expenses_dialog.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    Key? key,
    required this.clientNameCon,
    required this.phoneCon,
    required this.formKey,
    required this.percentCon,
    required this.focusNode,
  }) : super(key: key);
  final TextEditingController clientNameCon, phoneCon, percentCon;
  final GlobalKey<FormState> formKey;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    var topBodySalesCubit = BlocProvider.of<TopBodySalesCubit>(context);
    var accountingCubit = BlocProvider.of<AccountingCubit>(context);
    var fatorahItemsCubit = BlocProvider.of<FatorahItemsCubit>(context);
    var storeCubit = BlocProvider.of<StoreCubit>(context);
    return Padding(
      padding: EdgeInsets.all(20.sp),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BlocBuilder<FatorahItemsCubit, FatorahItemsState>(
                    builder: (context, state) {
                  if (state is ChangeFatorahItemsList) {
                    return ListView.separated(
                        itemCount: state.itemsList.length,
                        separatorBuilder: (context, index) => const Divider(
                              color: AppColors.black,
                              indent: 20,
                              endIndent: 20,
                            ),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: DefaultTextStyle(
                              style: TextStyle(
                                  fontSize: 20.sp, color: AppColors.black),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('${state.itemsList[index].productName}'),
                                  Text(
                                      '${state.itemsList[index].count} الكميه'),
                                  Text(
                                      'سعر: ${state.itemsList[index].productPrice}'),
                                  Text(
                                    'اجمالي: ${state.itemsList[index].itemTotalPrice}',
                                    style: const TextStyle(
                                        color: Color(0xff1d52ff),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            trailing: IconButton(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                topBodySalesCubit.fatorahProductsListIdAndCount
                                    .removeAt(index);
                                state.itemsList.removeAt(index);
                                fatorahItemsCubit
                                    .changeItemsList(state.itemsList);
                                topBodySalesCubit.emit(TopBodySalesInitial());
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          );
                        });
                  } else {
                    return Container();
                  }
                }),
              ),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 60.h,
                  child: ElevatedButton(
                      style:buttonStyle(Colors.red),
                      onPressed: () {
                        topBodySalesCubit.fatorahItemsList = [];
                        fatorahItemsCubit
                            .changeItemsList(topBodySalesCubit.fatorahItemsList);
                        focusNode.requestFocus();
                      },
                      child: const Text('حذف الفاتوره')),
                ),
                BlocBuilder<TopBodySalesCubit, TopBodySalesState>(
                  builder: (context, state) {
                    return CircleAvatar(
                      radius: 50.sp,
                      child: Text(
                        '${topBodySalesCubit.calcFatorahTotal(topBodySalesCubit.fatorahItemsList)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.sp),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 60.h,
                  child: ElevatedButton(
                      style: buttonStyle(AppColors.mainColor),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (topBodySalesCubit.fatorahItemsList.isNotEmpty) {
                            topBodySalesCubit.setFatorah();
                            await printFatorah(topBodySalesCubit.fatorahModel!);
                            storeCubit.upDateProductsCount(topBodySalesCubit.fatorahProductsListIdAndCount);
                            await fatorahItemsCubit.addProductToBestSellersBox(topBodySalesCubit.fatorahItemsList);
                            await accountingCubit.addNewOrder(topBodySalesCubit.fatorahModel!);
                            topBodySalesCubit.printFatorahAndSave();
                            fatorahItemsCubit.changeItemsList(topBodySalesCubit.fatorahItemsList);
                            topBodySalesCubit.emit(TopBodySalesInitial());
                            clientNameCon.text = '';
                            phoneCon.text = '';
                            percentCon.text = '';
                            focusNode.requestFocus();

                          }
                        }
                      },
                      child: const Text('تنفيذ الفاتوره')),
                ),
                SizedBox(
                  height: 60.h,
                  child: ElevatedButton(
                      style: buttonStyle(Colors.deepOrange),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (topBodySalesCubit.fatorahItemsList.isNotEmpty) {
                            topBodySalesCubit.setFatorah();
                            await printFatorah(topBodySalesCubit.fatorahModel!);
                            storeCubit.upDateProductsCount(topBodySalesCubit.fatorahProductsListIdAndCount);
                            await fatorahItemsCubit.addProductToBestSellersBox(topBodySalesCubit.fatorahItemsList);
                            accountingCubit.addNewOrderToDept(topBodySalesCubit.fatorahModel!);
                            topBodySalesCubit.printFatorahAndSave();
                            fatorahItemsCubit.changeItemsList(topBodySalesCubit.fatorahItemsList);
                            topBodySalesCubit.emit(TopBodySalesInitial());
                            clientNameCon.text = '';
                            phoneCon.text = '';
                            percentCon.text = '';
                            focusNode.requestFocus();
                          }
                        }
                      },
                      child: const Text('تنفيذ بالاجل')),
                ),
                SizedBox(
                  height: 60.h,
                  child: ElevatedButton(
                    style: buttonStyle(Colors.deepOrange),
                      onPressed: () {
                        GlobalKey<FormState> formKey = GlobalKey();
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => AddExpensesDialog(
                              focusNode: focusNode,
                              formKey: formKey,
                            ));
                      },
                      child: const Text('مصروفات خارجه')),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
 buttonStyle(Color color,[double? x]){
  return ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(12),
    backgroundColor: color
  );
 }

