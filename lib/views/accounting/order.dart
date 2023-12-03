import 'package:accounting/app/shared_pref.dart';
import 'package:accounting/data_cubites/accounting_cubit/accounting_cubit.dart';
import 'package:accounting/data_cubites/accounting_cubit/accounting_state.dart';
import 'package:accounting/data_cubites/store_cubit/store_cubit.dart';
import 'package:accounting/views/accounting/widgets/change_fatorah_dialog.dart';
import 'package:accounting/views/accounting/widgets/fatorah_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/func.dart';
import '../../domain_models/fatorah_model/fatorah_model.dart';
import '../../widgets/home_button.dart';
import '../home.dart';

class Order extends StatelessWidget {
  const Order({Key? key, required this.fatorah, required this.isDept}) : super(key: key);
  final FatorahModel fatorah;
  final bool isDept;
  @override
  Widget build(BuildContext context) {
    var accountingCubit= BlocProvider.of<AccountingCubit>(context);
    var store= BlocProvider.of<StoreCubit>(context);
    double total=0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
        actions: [
          IconButton(
              onPressed: ()async{
                await accountingCubit.returned(fatorah,store.allProductsList);
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Home()), (route) => false);
              },
              icon: const Icon(Icons.delete,color: Colors.pink,)),
          const SizedBox(width: 20,),
          // IconButton(onPressed: (){showDialog(context: context, builder: (context)=>ChangeFatorahDialog(fatorahModel: fatorah,));}, icon: const Icon(Icons.edit)),
          const SizedBox(width: 20,),
          IconButton(
              onPressed: ()async{
                await printFatorah(fatorah);
              },
              icon: const Icon(Icons.print)),
          const SizedBox(width: 20,),
          const HomeButton(),
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 400.w, vertical: 50.h),
          color: Colors.white,
          width: 500.w,
          child: DefaultTextStyle(
              style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  FatorahRow(name: SharedPref.name, phone: SharedPref.mobile,location: SharedPref.location,fatorah: fatorah, ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 60.h),
                    child: Table(
                      children: [
                        TableRow(
                            decoration: BoxDecoration(
                                border: Border.lerp(
                                    null,
                                    const Border(
                                        bottom: BorderSide(color: Colors.black)),
                                    1)),
                            children: const [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('الاجمالي'),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('السعر'),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('الكميه'),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('الوصف'),
                                ),
                              ),
                            ]),
                        ...fatorah.fatorahProductsList.map((e) {
                          total+= e.count * e.productPrice;
                          return TableRow(
                              decoration: BoxDecoration(
                                  border: Border.lerp(null, const Border(bottom: BorderSide(color: Colors.black)), 1)),
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0.sp),
                                    child: Text('${e.count * e.productPrice}'),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0.sp),
                                    child: Text('${e.productPrice}'),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0.sp),
                                    child: Text('${e.count}'),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0.sp),
                                    child: Text('${e.productName}'),
                                  ),
                                ),
                              ]);
                        }).toList()
                      ],
                    ),
                  ),                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الاجمالي $total',),
                          Text('خصم ${total-fatorah.fatorahTotal}',),
                          Text('${fatorah.fatorahTotal} EGP  بعد الخصم',),
                        ],
                      ),
                  ),
                 ],
               ),
              ),
          ),
        ),
      ),
      floatingActionButton:isDept? ElevatedButton(
        onPressed: (){
          showDialog(context: context, builder: (context)=>AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('سداد فاتوره بقيمة: ${fatorah.fatorahTotal}',style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.bold),),
                SizedBox(height: 20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  ElevatedButton(onPressed: ()async{
                    fatorah.createdAt=DateTime.now();
                    accountingCubit.deptList.remove(fatorah);
                    for(int i=0;i<accountingCubit.deptBox.length;i++){
                      if(accountingCubit.deptBox.getAt(i)==fatorah){
                        await accountingCubit.deptBox.deleteAt(i);
                      }
                    }
                    await accountingCubit.addNewOrder(fatorah);
                    accountingCubit.emit(DeptSearch());
                    accountingCubit.deptSearchList=accountingCubit.deptList;
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }, child: const Text('سداد')),
                  ElevatedButton(onPressed: ()=>Navigator.pop(context), child: const Text('الغاء')),
                ],)
              ],
            ),
          ));
        },
        child: const Text('سداد الفاتوره'),
      ):null,
    );
  }
}

