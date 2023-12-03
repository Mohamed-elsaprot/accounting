import 'dart:io';

import 'package:accounting/app/app_colors.dart';
import 'package:accounting/app/shared_pref.dart';
import 'package:accounting/app/func.dart';
import 'package:accounting/data_cubites/accounting_cubit/accounting_cubit.dart';
import 'package:accounting/data_cubites/store_cubit/store_cubit.dart';
import 'package:accounting/data_cubites/today-sales_cubit/bottombody_sales_cubit/bottombody_sales_cubit.dart';
import 'package:accounting/data_cubites/today-sales_cubit/topbody_sales_cubit/topbody_sales_cubit.dart';
import 'package:accounting/views/home.dart';
import 'package:accounting/widgets/diffirent_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory path = await getApplicationDocumentsDirectory();
  print(path);
  Widget screen = await SharedPref.check()? const Home():const DifferentId();
  await SharedPref.getMarketData();
  await Hive.initFlutter();
  await openHiveBoxes();
  runApp(MyApp(screen: screen,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.screen});
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => StoreCubit()..getProductsFromHive()),
        BlocProvider(
            create: (context) =>
                AccountingCubit()..getAllOrdersAndExpensesListFromHive()),
        BlocProvider(
          create: (context) => TopBodySalesCubit(),
        ),
        BlocProvider(
          create: (context) => FatorahItemsCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(1280, 953),
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: AppColors.mainColor,
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                          fontSize: 22.sp,fontWeight: FontWeight.bold),
                      elevation: 0,
                      backgroundColor: AppColors.mainColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r)),
                      padding: EdgeInsets.all(18.sp))),
              appBarTheme: const AppBarTheme(
                  color: AppColors.mainColor, centerTitle: true, elevation: 0),
              scaffoldBackgroundColor: AppColors.scaffoldColor,
              textTheme: TextTheme(
                bodyMedium: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
            home: screen
          );
        },
      ),
    );
  }
}



