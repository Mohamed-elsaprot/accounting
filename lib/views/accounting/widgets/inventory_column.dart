import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/app_colors.dart';

class InventoryColumn extends StatelessWidget {
  const InventoryColumn({Key? key, required this.date, required this.gard, required this.buy, required this.sell, required this.profit}) : super(key: key);
  final String date;
  final bool gard;
  final double buy,sell,profit;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade200,
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 20.sp,
          color: AppColors.black,
        ),
        child: Column(
          children:gard? [
            Text(date),
            Divider(indent: 10.w,endIndent: 10.w, color: AppColors.black,),
             Text('بيع: $sell'),
             Text('شراء: $buy'),
            Divider(indent: 10.w,endIndent: 10.w, color: AppColors.black,),
             Text('صافي ربح : $profit'),
          ]:[],
        ),
      ),
    );
  }
}
