import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FatorahPrice extends StatelessWidget {
  const FatorahPrice({Key? key, required this.price, required this.tax,}) : super(key: key);
  final num price,tax;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(50.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('القيمه: $price ج.م'),
          Text('ضريبه: $tax ج.م'),
          Text('اجمالي: ${price+tax} ج.م'),
        ],
      ),
    );
  }
}
