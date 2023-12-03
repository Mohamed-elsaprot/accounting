import 'package:accounting/domain_models/fatorah_model/fatorah_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeFatorahDialog extends StatefulWidget {
  const ChangeFatorahDialog({Key? key, required this.fatorahModel})
      : super(key: key);
  final FatorahModel fatorahModel;

  @override
  State<ChangeFatorahDialog> createState() => _ChangeFatorahDialogState();
}

class _ChangeFatorahDialogState extends State<ChangeFatorahDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (size.width < 700 || size.height < 510) {
      return AlertDialog();
    } else {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...widget.fatorahModel.fatorahProductsList.map((e) {
                // TextEditingController count=TextEditingController(), total =TextEditingController();
                // count.text=e.count.toString();total.text=(e.count * e.productPrice).toString();
                return SizedBox(
                  width: 600.w,
                  child: Column(
                    children: [
                      DefaultTextStyle(
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(e.productName.toString()),
                            Text('${e.count}  كميه'),
                            Text('${e.itemTotalPrice}  اجمالي'),
                            IconButton(
                                onPressed: () {
                                  widget.fatorahModel.fatorahProductsList.remove(e);
                                  widget.fatorahModel.fatorahTotal-=e.itemTotalPrice;
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ))
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      )
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      );
    }
  }
}

//Flexible(
//                           child: CustomTextField(
//                             controller: count,
//                           )),
//                       SizedBox(width: 10.w,),
//                       Flexible(child: CustomTextField(
//                         controller: total,
//                       )
//                       ),
