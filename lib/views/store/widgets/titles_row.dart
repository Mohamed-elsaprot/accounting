import 'package:accounting/app/app_colors.dart';
import 'package:accounting/app/func.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitlesRow extends StatelessWidget {
  const TitlesRow({Key? key,required this.id,required this.name,required this.price,required this.count, required this.isTitle}) : super(key: key);
  final String id,name,price,count;
  final bool isTitle;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontWeight:isTitle? FontWeight.w600:FontWeight.w400,fontSize:isTitle? 24.sp:22.sp,color: AppColors.black),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(id),
          Text(split(name, 18),textAlign: TextAlign.start),
          Text(price),
          Text(count),
        ],
      ),
    );
  }
}
