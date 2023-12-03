import 'package:accounting/views/today_sales/widgets/client_data_form.dart';
import 'package:accounting/views/today_sales/widgets/order_details.dart';
import 'package:accounting/views/today_sales/widgets/today_sales_top_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodaySales extends StatelessWidget {
  const TodaySales({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> productKey = GlobalKey();
    final GlobalKey<FormState> percentSaleKey = GlobalKey();
    Size size = MediaQuery.of(context).size;
    TextEditingController clientNameCon = TextEditingController(), phoneCon = TextEditingController(), percentCon = TextEditingController();
    FocusNode focusNode = FocusNode();
    focusNode.requestFocus();
    if (size.width < 760 || size.height < 560) {
      return Center(
        child: Text(
          'حجم الشاشه  غير مناسب',
          style: TextStyle(fontSize: 50.sp),
        ),
      );
    } else {
    print(size);
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Form(
                key: productKey,
                child: TopBody(
                  focusNode: focusNode,
                  formKey: productKey,
                ),
              ),
              Form(
                  key: percentSaleKey,
                  child: ClientDataForm(
                      percentCon: percentCon,
                      clientNameCon: clientNameCon,
                      phoneCon: phoneCon),
              ),
              Expanded(
                  child: OrderDetails(
                    focusNode: focusNode,
                    formKey: percentSaleKey,
                    clientNameCon: clientNameCon,
                    phoneCon: phoneCon,
                    percentCon: percentCon,
                  ),

              ),
            ],
          ),
        ),
      );
    }
  }
}
