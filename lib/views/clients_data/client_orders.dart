import 'package:accounting/app/app_colors.dart';
import 'package:accounting/data_cubites/accounting_cubit/accounting_cubit.dart';
import 'package:accounting/data_cubites/accounting_cubit/accounting_state.dart';
import 'package:accounting/views/accounting/order.dart';
import 'package:accounting/views/home.dart';
import 'package:accounting/widgets/widgets_fun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain_models/fatorah_model/fatorah_model.dart';
import '../../widgets/custom_textfield.dart';

class ClientOrders extends StatelessWidget {
  const ClientOrders({Key? key, required this.clientOrders}) : super(key: key);
  final List<FatorahModel> clientOrders;

  @override
  Widget build(BuildContext context) {
    List<FatorahModel> searchList=clientOrders;
    var accountingCubit= BlocProvider.of<AccountingCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${clientOrders[0].clientPhone}'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Home()),
                  (route) => false),
              icon: const Icon(Icons.home))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      title:'بحث بالتاريخ',
                      onChange: (x){
                        if(x.isNotEmpty){
                          searchList = clientOrders.where((element) {
                            int hour=element.createdAt.hour;
                            if(element.createdAt.hour>12){
                              hour-=12;
                            }
                            String date = '${element.createdAt.day}/${element.createdAt.month}/${element.createdAt.year} $hour:${element.createdAt.minute}';
                            return date.contains(x);
                          }).toList();
                        }else{
                          searchList=clientOrders;
                        }
                        accountingCubit.emit(ClientOrdersSearch());
                      },
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  ElevatedButton(onPressed: (){
                    showDialog(context: context, builder: (context) {
                      double x=0;
                      searchList.forEach((element) {
                        x+=element.fatorahTotal;
                      });
                      return AlertDialog(
                        content: Text('اجمالي المشتريات: $x ج.م',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.sp),),
                    );
                    });
                  }, child: const Text('حساب اجمالي المشتريات'))
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child:BlocBuilder<AccountingCubit,AccountingState>(builder: (context,state){
                return  ListView.separated(
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Order(
                                  fatorah: searchList[index],
                                  isDept: false,
                                )));
                      },
                      trailing: Text('${searchList[index].fatorahTotal}'),
                      leading:
                      Text(dayAndTime(searchList[index].createdAt)),
                    ),
                    separatorBuilder: (context, index) => const Divider(
                      color: AppColors.black,
                      indent: 10,
                      endIndent: 10,
                    ),
                    itemCount: searchList.length);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
