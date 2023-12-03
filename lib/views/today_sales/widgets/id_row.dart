import 'package:accounting/domain_models/fatorah_model/fatorah_item_model/fatorah_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_colors.dart';
import '../../../data_cubites/store_cubit/store_cubit.dart';
import '../../../data_cubites/today-sales_cubit/topbody_sales_cubit/topbody_sales_cubit.dart';
import '../../../widgets/custom_textfield.dart';
import 'auto_complete_textfield.dart';

class IdRow extends StatelessWidget {
  const IdRow({Key? key, required this.idC, required this.countC, required this.focusNode})
      : super(key: key);
  final TextEditingController idC, countC;
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    var storeCubit = BlocProvider.of<StoreCubit>(context);
    var salesCubit = BlocProvider.of<TopBodySalesCubit>(context);
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            title: 'id',
            controller: idC,
            focusNode: focusNode,
            onSaved: (x) => idC.text = '',
            color: AppColors.mainColor.withOpacity(.3),
            validator: (x) {
              if (salesCubit.product == null) {
                return 'من فضلك اختار المنتج';
              } else {
                return null;
              }
            },
            onChange: (x) {
              if (storeCubit.productsIdList().contains(x)) {
                salesCubit.product = storeCubit.allProductsList.firstWhere((element) => x == element.id);
                if(salesCubit.product!=null) {
                  focusNode.unfocus();
                  countC.text = '1';
                }
              } else {
                salesCubit.product = null;
              }
              salesCubit.checkProduct();
            },
          ),
        ),
        const SizedBox(width: 20,),
        Expanded(
          child: AutoCompleteTextField(
            validator: (x) {
              if (salesCubit.product == null) {
                return 'من فضلك اختار المنتج';
              } else {
                return null;
              }
            },
            onChange: (x) {
              if (storeCubit.productsNamesList().contains(x)) {
                salesCubit.product = storeCubit.allProductsList.firstWhere((element) => x == element.name);
                if(salesCubit.product!=null) countC.text='1';
              } else {
                salesCubit.product = null;
              }
              salesCubit.checkProduct();
            },
            onSelected: (x) {
              salesCubit.product = storeCubit.allProductsList.firstWhere((element) => x == element.name);
              if(salesCubit.product!=null) countC.text='1';
              salesCubit.checkProduct();
            },
            title: 'اسم المنتج',
            words: storeCubit.productsNamesList(),
          ),
        ),
        const SizedBox(width: 20,),
        Expanded(
          child: CustomTextField(
            title: 'الكميه',
            controller: countC,
            onSaved: (x) {
              countC.text = '';
            },
            validator: (x) {
              if (salesCubit.product != null) {
                double countFromFatorah=0;
                List<FatorahModelItem> itemFromFatorah= salesCubit.fatorahItemsList.where((element) => element.productName==salesCubit.product!.name).toList();
                itemFromFatorah.forEach((element) {
                  countFromFatorah+= element.count;
                });
                if (x!.isEmpty || double.tryParse(x!) == null) {
                  return 'من فضلك ادخل رقم صحيح';
                } else {
                  double neededCount = double.parse(x);
                  if ((salesCubit.product!.count! - countFromFatorah) >= neededCount) {
                    salesCubit.count = neededCount;
                    print('needed count: ${salesCubit.count}');
                    return null;
                  } else {
                    return 'الكميه المطلوبه اكبر من المتاح';
                  }
                }
              } else {
                return 'من فضلك اختار المنتج';
              }
            },
          ),
        ),
      ],
    );
  }
}
