import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/app_colors.dart';

class YearInventoryContainer extends StatelessWidget {
  const YearInventoryContainer({Key? key, required this.gard, required this.sell, required this.buy, required this.profit}) : super(key: key);
  final bool gard;
  final double sell,buy,profit;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 150.w, vertical: 50.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.black, width: 1)),
      child: DefaultTextStyle(
        style: TextStyle(color: AppColors.black, fontSize: 20.sp),
        child: Column(
          children: gard ? [
             Text('بيع: $sell'),
             Text('شراء: $buy'),
            Divider(endIndent: 150.w, indent: 150.w, color: AppColors.black,),
            Text('صافي الربح : $profit'),
          ] : [],
        ),
      ),
    );
  }
}
