import 'package:accounting/data_cubites/accounting_cubit/accounting_cubit.dart';
import 'package:accounting/data_cubites/store_cubit/store_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain_models/expenses_model/expenses_model.dart';
import '../../../widgets/custom_textfield.dart';

class AddExpensesDialog extends StatelessWidget {
  const AddExpensesDialog({Key? key, required this.formKey, required this.focusNode, }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    var storeCubit =BlocProvider.of<StoreCubit>(context);
    var accountingCubit = BlocProvider.of<AccountingCubit>(context);
    FocusNode f1= FocusNode();
    FocusScope.of(context).requestFocus(f1);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      content: SizedBox(
        width: 800,
        child: Form(
          key: formKey,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: CustomTextField(
                title: 'عنوان',
                validator: (x){
                  if(x!.isEmpty){
                    return 'خانه مطلوبه';
                  }else{
                    return null;
                  }
                },
                onSaved: (x)=> storeCubit.title=x,
              )),
              const SizedBox(width: 50,),
              Expanded(child: CustomTextField(
                title: 'المبلغ',
                validator: (x){
                  if(x!.isEmpty){
                    return 'خانه مطلوبه';
                  }else if(double.tryParse(x!)==null){
                    return 'من فضلك ادخل قيمه صحيحه';
                  }else{
                    return null;
                  }
                },
                onSaved: (x)=>storeCubit.amountOfMoney= double.parse(x!),
              )),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(onPressed: (){
          if(formKey.currentState!.validate()){
            formKey.currentState!.save();
            accountingCubit.addExpenses(ExpensesModel(title: storeCubit.title!, amountOfMoney: storeCubit.amountOfMoney, dateTime: DateTime.now()));
            Navigator.pop(context);
          }
        }, child: const Text('اضافه')),
        ElevatedButton(onPressed: () {
          focusNode.requestFocus();
          Navigator.pop(context);
        }, child: const Text('اغلاق')),
      ],
    );
  }
}
