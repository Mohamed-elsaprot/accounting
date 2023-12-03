import 'package:accounting/app/app_colors.dart';
import 'package:accounting/data_cubites/accounting_cubit/accounting_cubit.dart';
import 'package:accounting/data_cubites/accounting_cubit/accounting_state.dart';
import 'package:accounting/domain_models/fatorah_model/fatorah_model.dart';
import 'package:accounting/widgets/widgets_fun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_textfield.dart';
import 'client_orders.dart';

class ClientsData extends StatelessWidget {
  const ClientsData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var accountingCubit = BlocProvider.of<AccountingCubit>(context);
    List<FatorahModel> clientsOrders = [];
    accountingCubit.allOldOrders.forEach((element) {
      if (element.clientPhone != 'No Number') {
        clientsOrders.add(element);
      }
    });
    List<FatorahModel> searchList= clientsOrders;
    if (size.width < 700 || size.height < 150) {
      return Center(
        child: Text(
          'حجم الشاشه غير مناسب',
          style: TextStyle(fontSize: 40.sp),
        ),
      );
    } else {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        title: 'بحث برقم الهاتف',
                        onChange: (x) {
                          if(x.isNotEmpty){
                            searchList = clientsOrders.where((element) => element.clientPhone!.contains(x)).toList();
                          }else{
                            searchList=clientsOrders;
                          }
                          accountingCubit.emit(ClientOrdersSearch());
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: CustomTextField(
                        title: 'بحث بالاسم',
                        onChange: (x) {
                          if(x.isNotEmpty){
                            searchList = clientsOrders.where((element) => element.clientName!.contains(x)).toList();
                          }else{
                            searchList=clientsOrders;
                          }
                          accountingCubit.emit(ClientOrdersSearch());
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 10,
                child: BlocBuilder<AccountingCubit,AccountingState>(builder: (context, state) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemBuilder: (context, index) {
                      List<FatorahModel> client = searchList.where((element) =>element.clientPhone == searchList[index].clientPhone)
                          .toList();
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ClientOrders(clientOrders: client)));
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(searchList[index].clientName!),
                            Text(searchList[index].clientPhone!),
                            Text(dayAndTime(searchList[index].createdAt)),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      indent: 50,
                      endIndent: 50,
                      color: AppColors.black,
                    ),
                    itemCount: searchList.length,
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
