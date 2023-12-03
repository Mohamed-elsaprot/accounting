import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/app_colors.dart';
import '../../../domain_models/fatorah_model/fatorah_model.dart';
import '../../../widgets/widgets_fun.dart';

class FatorahRow extends StatelessWidget {
  const FatorahRow({Key? key, required this.name, required this.phone, required this.fatorah, required this.location}) : super(key: key);
  final String name,phone,location;
  final FatorahModel fatorah;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          '$name\n  $phone\n $location',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.black, fontSize: 20.sp),
        ),
        Column(
          children: [
            Text(
              'فاتورة',
              style: TextStyle(color: AppColors.black, fontSize: 55.sp),
            ),
            SizedBox(height: 10.h,),
            Text(dayAndTime(fatorah.createdAt),style: TextStyle(fontSize: 14.sp),)
          ],
        ),
      ],
    );
  }
}
