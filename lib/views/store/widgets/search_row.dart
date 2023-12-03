import 'package:accounting/app/func.dart';
import 'package:accounting/data_cubites/store_cubit/store_cubit.dart';
import 'package:accounting/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchRow extends StatelessWidget {
  const SearchRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var storeCubit = BlocProvider.of<StoreCubit>(context);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: CustomTextField(
              title: 'البحث عن منتج بالاسم',
              onChange: (x) =>
                  storeCubit.updateSearchProductsSearchList(x, 'name')),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            flex: 1,
            child: CustomTextField(
              title: 'البحث عن فئه',
              onChange: (x) =>
                  storeCubit.updateSearchProductsSearchList(x, 'category'),
            )),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            flex: 1,
            child: CustomTextField(
              title: 'بحث id',
              onChange: (x) =>
                  storeCubit.updateSearchProductsSearchList(x, 'id'),
            )),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => addProductDialog(
                          context,
                          storeCubit.addNewProduct,
                        ));
              },
              child: const Text('اضافة منتج')),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      late double price;
                      GlobalKey<FormState> formKey=GlobalKey();
                      return AlertDialog(
                        content: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextField(
                                title: 'نسبة الزياده \%',
                                validator: (x){
                                  if (double.tryParse(x!) == null) {
                                    return 'من فضلك ادخل رقم صحيح';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (x)=> price=double.parse(x!),
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        if(formKey.currentState!.validate()){
                                          formKey.currentState!.save();
                                          storeCubit.updateAllPrices(price);
                                          Navigator.pop(context);
                                        }

                                      },
                                      child: const Text('تعديل السعر')),
                                  SizedBox(width: 5.w,),
                                  ElevatedButton(
                                    onPressed: ()=>Navigator.pop(context),
                                    child: const Text('اغلاق'),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: const Text('تعديل سعر الكل \%')),
        ),
      ],
    );
  }
}
