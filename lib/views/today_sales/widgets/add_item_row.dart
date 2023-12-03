import 'package:accounting/data_cubites/today-sales_cubit/bottombody_sales_cubit/bottombody_sales_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/app_colors.dart';
import '../../../data_cubites/today-sales_cubit/topbody_sales_cubit/topbody_sales_cubit.dart';
import '../../../data_cubites/today-sales_cubit/topbody_sales_cubit/topbody_sales_state.dart';
import '../../../widgets/custom_textfield.dart';

class AddItemRow extends StatelessWidget {
  const AddItemRow({Key? key, required this.manualSaleC, required this.formKey, required this.focusNode}) : super(key: key);
  final TextEditingController manualSaleC;
  final GlobalKey<FormState> formKey;
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    var salesCubit = BlocProvider.of<TopBodySalesCubit>(context);
    var fatorahItemsCubit = BlocProvider.of<FatorahItemsCubit>(context);
    return Row(
      children: [
       Expanded(
         child: CustomTextField(
                title: 'خصم يدوي',
                controller: manualSaleC,
                onSaved:(x)=> manualSaleC.text='',
                validator: (x) {
                  if (x!.isEmpty) return null;
                  if (double.tryParse(x!) == null) {
                    return 'من فضلك ادخل رقم صحيح';
                  } else {
                    salesCubit.manualSale= double.parse(x!);
                    print('manual Sale: ${salesCubit.manualSale}');
                    return null;
                  }
                },
              ),
       ),
        SizedBox(width: 80.sp,),
        Row(
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w)),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    salesCubit.addFatorahItem(productName: salesCubit.product!.name, productPrice: salesCubit.product!.sellPrice, count: salesCubit.count!,productBuyingPrice: salesCubit.product!.buyingPrice);
                    salesCubit.addToProductsList(salesCubit.product!);
                    formKey.currentState!.save();
                    salesCubit.resetData();
                    fatorahItemsCubit.changeItemsList(salesCubit.fatorahItemsList);
                    salesCubit.emit(TopBodySalesInitial());
                    focusNode.requestFocus();
                  }
                },
                child: Text(
                  'اضافه للفاتوره',
                  style: TextStyle(fontSize: 20.sp),
                )),
            SizedBox(
              width: 8.w,
            ),
            BlocBuilder<TopBodySalesCubit,TopBodySalesState>(builder: (context,state){
              return Row(
                children: [
                  Checkbox(
                      value: salesCubit.sale,
                      onChanged: (x) {
                        salesCubit.setAvailableSale(x!);
                      }),
                  Text(
                    'خصم',
                    style: TextStyle(fontSize: 18.sp, color: AppColors.black),
                  ),
                  SizedBox(width: 10.w,),
                  CircleAvatar(
                    child: Text('${salesCubit.availableSale}'),
                  ),
                ],
              );
            }),
            SizedBox(width: 20.w,),
            SizedBox(
              width: 290,
              child: BlocBuilder<TopBodySalesCubit,TopBodySalesState>(builder: (context,state){
                if(state is ProductNotNull){
                  return const Text('');
                }else {
                  return const Text('من فضلك تأكد من اختيار العنصر');
                }
              }),
            ),
            SizedBox(width: 180.w,),
          ],
        ),
      ],
    );
  }
}
