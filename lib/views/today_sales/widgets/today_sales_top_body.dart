import 'package:accounting/views/today_sales/widgets/add_item_row.dart';
import 'package:accounting/views/today_sales/widgets/id_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/app_colors.dart';

class TopBody extends StatelessWidget {
  const TopBody({Key? key, required this.formKey, required this.focusNode}) : super(key: key);
  final GlobalKey<FormState> formKey;
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    final idC = TextEditingController(), countC = TextEditingController(), manualSaleC = TextEditingController();
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        IdRow(idC: idC, countC: countC, focusNode: focusNode,),
        SizedBox(height: 20.h,),
        AddItemRow(manualSaleC: manualSaleC, formKey: formKey, focusNode: focusNode,),
        SizedBox(height: 20.h,),
        Divider(color: AppColors.black,height: 40.h,),
      ],
    );
  }
}
