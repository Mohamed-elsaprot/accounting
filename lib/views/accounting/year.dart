import 'package:accounting/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain_models/fatorah_model/fatorah_model.dart';
import 'months.dart';


class Year extends StatelessWidget {
  const Year({Key? key, required this.yearOrders, }) : super(key: key);
  final List <FatorahModel> yearOrders;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Months(monOrders: yearOrders,year: '${yearOrders[0].createdAt.year}',)));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20.r)),
          alignment: Alignment.center,
          child: Text('${yearOrders[0].createdAt.year}',style: const TextStyle(color: AppColors.white),),
        ),
      ),
    );
  }
}


