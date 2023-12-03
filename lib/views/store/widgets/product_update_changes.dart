import 'package:accounting/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductUpdateChanges extends StatelessWidget {
  const ProductUpdateChanges(
      {Key? key,
      required this.id,
      required this.name,
      required this.category,
      required this.buy,
      required this.sell,
      required this.gomla,
      required this.packageCount,
      required this.packageItemsCount,
      required this.count,
      required this.availableSale,
      required this.dateTime,
      required this.function,
      required this.currentId})
      : super(key: key);
  final String currentId, id, name, category;
  final double buy,
      sell,
      gomla,
      packageCount,
      packageItemsCount,
      count,
      availableSale;
  final DateTime dateTime;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.all(15.sp),
      title: const Text(' هل انت متأكد من تعديل هذا العنصر !'),
      content: DefaultTextStyle(
        style: TextStyle(fontSize: 22.sp, color: AppColors.black),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$id : id'),
            Text('الاسم : $name'),
            Text('الفئه : $category '),
            Text('سعر الشراء : $buy '),
            Text('سعر البيع : $sell '),
            Text('سعر الجمبه : $gomla '),
            Text('عدد المجموعات : $packageCount '),
            Text('عدد العناصر في المجموعه : $packageItemsCount '),
            Text('عدد القطع : $count '),
            Text('الخصم المتاح : $availableSale '),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () async {
             await function(
                currentId: currentId,
                name: name,
                id: id,
                category: category,
                buyingPrice: buy,
                sellPrice: sell,
                gomlaPrice: gomla,
                packageCount: packageCount,
                packageItemsCount: packageItemsCount,
                count: count,
                availableSale: availableSale,
                dateTime: dateTime,
              );
              Navigator.pop(context);
            },
            child: Text('نعم', style: TextStyle(fontSize: 18.sp),),),
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('اغلاق', style: TextStyle(fontSize: 18.sp),)),
      ],
    );
  }
}
