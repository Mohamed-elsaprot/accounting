import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../widgets/widgets_fun.dart';

class AutoCompleteTextField extends StatelessWidget {
  const AutoCompleteTextField({Key? key, required this.words, required this.title, this.color, this.onSelected, this.onChange, this.validator,}) : super(key: key);
  final List<String> words;
  final String title;
  final Color? color;
  final Function(String x)? onSelected;
  final Function(String x)? onChange;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue){
        if(textEditingValue.text == ''|| textEditingValue.text.isEmpty){
          return const Iterable<String>.empty();
        }
        return words.where((String element) {
          return (element.contains(textEditingValue.text) ||element.contains(textEditingValue.text.toLowerCase()) || element.contains(textEditingValue.text.toUpperCase()));
        });
      },
      fieldViewBuilder: (context,controller,focusNode,onEditingComplete){
        return TextFormField(
          validator: validator,
          controller: controller,
          focusNode: focusNode,
          onChanged: onChange,
          onSaved: (x)=>controller.text='',
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
              filled: true,
              fillColor: color,
              label: Text(title,style: TextStyle(fontSize: 18.sp),),
              focusedBorder: border(),
              enabledBorder: border(),
              errorBorder: border(),
              focusedErrorBorder: border(),
          ),
        );
      },
      onSelected:onSelected,
    );
  }
}
