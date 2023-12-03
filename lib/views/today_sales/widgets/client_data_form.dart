import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data_cubites/today-sales_cubit/topbody_sales_cubit/topbody_sales_cubit.dart';
import '../../../data_cubites/today-sales_cubit/topbody_sales_cubit/topbody_sales_state.dart';
import '../../../widgets/custom_textfield.dart';

class ClientDataForm extends StatelessWidget {
  const ClientDataForm({Key? key, required this.clientNameCon, required this.phoneCon, required this.percentCon}) : super(key: key);
  final TextEditingController clientNameCon,phoneCon,percentCon;
  @override
  Widget build(BuildContext context) {
    final salesCubit=BlocProvider.of<TopBodySalesCubit>(context);
    final topBodySalesCubit=BlocProvider.of<TopBodySalesCubit>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                  title: 'اسم العميل',
                  onChange: (x){
                    if(x.isNotEmpty){
                      salesCubit.clientName = x;
                    }else {
                      salesCubit.clientName='No Name';
                    }
                  },
                  controller: clientNameCon,
                ),
              ),
              SizedBox(width: 50.w,),
              Expanded(
                child: CustomTextField(
                  title: 'رقم الموبايل',
                  onChange: (x){
                    if(x.isNotEmpty){
                      salesCubit.clientPhone = x;
                    }else {
                      salesCubit.clientPhone='No Number';
                    }
                  },
                  controller: phoneCon,
                ),
              ),
              SizedBox(width: 50.w,),
              Expanded(
                child: CustomTextField(
                  title: 'خصم شامل بالنسبه المئويه',
                  controller: percentCon,
                  onChange: (x) {
                      salesCubit.percentageSale= double.tryParse(x)??0;
                      topBodySalesCubit.emit(TopBodySalesInitial());
                  },
                  validator: (x) {
                    if (x!.isEmpty) return null;
                    if (double.tryParse(x!) == null) {
                      return 'من فضلك ادخل رقم صحيح';
                    } else {
                      salesCubit.percentageSale= double.parse(x!);
                      return null;
                    }
                  },
                ),
              ),
            ],
          ),
    );
  }
}
