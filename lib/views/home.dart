import 'package:accounting/app/app_colors.dart';
import 'package:accounting/app/func.dart';
import 'package:accounting/data_cubites/accounting_cubit/accounting_cubit.dart';
import 'package:accounting/data_cubites/store_cubit/store_cubit.dart';
import 'package:accounting/data_cubites/today-sales_cubit/topbody_sales_cubit/topbody_sales_cubit.dart';
import 'package:accounting/domain_models/best_sellers/best_seller.dart';
import 'package:accounting/views/depts/depts.dart';
import 'package:accounting/views/store/store.dart';
import 'package:accounting/views/today_sales/today_sales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../data_cubites/store_cubit/store_state.dart';
import '../data_cubites/today-sales_cubit/bottombody_sales_cubit/bottombody_sales_cubit.dart';
import 'accounting/accounting.dart';
import 'clients_data/clients_data.dart';
import 'expenses/expenses.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var storeCubit = BlocProvider.of<StoreCubit>(context);
    var accountingCubit = BlocProvider.of<AccountingCubit>(context);
    var salesCubit = BlocProvider.of<TopBodySalesCubit>(context);
    var fatorahItemsCubit = BlocProvider.of<FatorahItemsCubit>(context);
    Size size = MediaQuery.of(context).size;
    if (size.width < 450 || size.height < 350) {
      return Scaffold(
        body: Center(
          child: Text(
            'حجم الشاشه غير مناسب',
            style: TextStyle(fontSize: 40.sp),
          ),
        ),
      );
    }
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20.h,),
          Row(
            children: [
              Expanded(
                flex: 12,
                child: Container(
                  margin: EdgeInsets.only(top: 15.h, left: 10.w, right: 10.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColors.mainColor),
                  child: GNav(
                    color: Colors.white,
                    activeColor: Colors.white,
                    tabBackgroundColor: Colors.black12,
                    rippleColor: Colors.black12,
                    onTabChange: (x) => setState(() {
                      storeCubit.searchProductsList =
                          storeCubit.allProductsList;
                      accountingCubit.expensesSearchList =
                          accountingCubit.expensesList;
                      salesCubit.resetData();
                      index = x;
                    }),
                    selectedIndex: index,
                    textStyle: TextStyle(color: Colors.white, fontSize: 20.sp),
                    padding: EdgeInsets.all(10.r),
                    gap: 20.sp,
                    iconSize: 30.sp,
                    tabMargin:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                    tabs: const [
                      GButton(
                        icon: Icons.monetization_on,
                        text: 'حسابات',
                      ),
                      GButton(icon: Icons.store, text: 'مخزن'),
                      GButton(
                          icon: Icons.data_exploration, text: 'مبيعات اليوم'),
                      GButton(icon: Icons.error_outline_rounded, text: 'مبيعات اجله'),
                      GButton(icon: Icons.assessment_outlined, text: 'مصروفات'),
                      GButton(icon: Icons.person, text: 'سجل العملاء'),
                      // GButton(icon: Icons.settings, text: 'الاعدادات'),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: MaterialButton(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    List outOfStock = storeCubit.getOutOfStockProduct();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              textAlign: TextAlign.end,
                              'تحذير نفاذ: ${outOfStock.length}',
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            content: SizedBox(
                              height: 400.h,
                              width: 400.w,
                              child: ListView.separated(
                                  itemCount: outOfStock.length,
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                        color: AppColors.black,
                                      ),
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: Text(split(outOfStock[index], 25)),
                                    );
                                  }),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'اغلاق',
                                    style: TextStyle(fontSize: 20.sp),
                                  ))
                            ],
                          );
                        });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.notifications,
                        color: Colors.blue,
                        size: 60.sp,
                      ),
                      Positioned(
                        right: 1.w,
                        top: 10.h,
                        child: CircleAvatar(
                          radius: 15.sp,
                          backgroundColor: AppColors.white,
                          child: BlocBuilder<StoreCubit, StoreState>(
                              builder: (context, state) {
                            return Text(
                              storeCubit.getOutOfStockProduct().length.toString(),
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: MaterialButton(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    showDialog(context: context, builder: (context) {
                      List<BestSeller> list =fatorahItemsCubit.getBestSellers();
                      return AlertDialog(
                      content: SizedBox(
                        height: 400.h,
                        width: 400.w,
                        child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context,index){
                              return ListTile(
                                leading: Text(split(list[index].name, 25)),
                                trailing: Text(split(list[index].count.toString(), 5)),
                              );
                            }),
                      ),
                        actions: [ElevatedButton(onPressed:()=>Navigator.pop(context) , child: Text('اغلاق',style: TextStyle(fontSize: 20.sp)))],
                    );
                    });
                  },
                  child: Image.asset('assets/images/best-seller.png'),
                ),
              ),
            ],
          ),
          list[index]
        ],
      ),
    );
  }
}

const List list = [
  Accounting(),
  Store(),
  TodaySales(),
  DeptOrders(),
  Expenses(),
  ClientsData(),
];
