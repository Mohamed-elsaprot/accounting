import 'package:accounting/app/app_colors.dart';
import 'package:accounting/widgets/widgets_fun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key,this.onChange, this.controller, this.onTap, this.color, this.validator, this.title, this.onSaved, this.focusNode, this.secure}) : super(key: key);
  final String? title;
  final Function(String)? onChange;
  final TextEditingController? controller;
  final Function()? onTap;
  final Color? color;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final FocusNode? focusNode;
  final bool? secure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
    onSaved: onSaved,
      controller: controller,
      onChanged:onChange,
      onTap: onTap,
      validator:validator,
      focusNode: focusNode,
      obscureText: secure??false,
      decoration: InputDecoration(
        filled: true,
          fillColor: color,
          label: Text(title??''),
          labelStyle: TextStyle(fontSize: 20.sp,color: AppColors.black),
          focusedBorder: border(),
          enabledBorder: border(),
          errorBorder: border(),
          focusedErrorBorder: border(),
      ),
    );
  }
}
