import 'package:accounting/views/home.dart';
import 'package:flutter/material.dart';
import 'package:accounting/widgets/custom_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/shared_pref.dart';

class DifferentId extends StatefulWidget {
  const DifferentId({Key? key}) : super(key: key);

  @override
  State<DifferentId> createState() => _DifferentIdState();
}

class _DifferentIdState extends State<DifferentId> {
  var globalKey = GlobalKey<FormState>();
  String? name,mobile,location;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Form(
          key: globalKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 400.h, child: Image.asset('assets/images/welcome.png')),
                  SizedBox(
                    width: 250.w,
                    child: CustomTextField(
                      title: 'الاسم',
                      onSaved: (x)=>name=x,
                      validator: (x)=>null,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: 250.w,
                    child: CustomTextField(
                      title: 'العنوان',
                      onSaved: (x)=>location=x,
                      validator: (x)=>null,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: 250.w,
                    child: CustomTextField(
                      title: 'رقم الموبايل',
                      onSaved: (x)=>mobile=x,
                      validator: (x)=>null,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: 250.w,
                    child: CustomTextField(
                      title: 'Password',
                      secure: true,
                      onSaved: (x){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Home()));
                      },
                      validator: (x){
                        DateTime date = DateTime.now();
                        int hour= date.hour>12? date.hour-12:date.hour;
                        if(x=='${date.month}${date.day}$hour${date.minute}'){
                          return null;
                        }else{
                          return 'wrong password';
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 15,),
                  ElevatedButton(
                      onPressed: ()async{
                        if(globalKey.currentState!.validate()){
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          globalKey.currentState!.save();
                          await prefs.setString('check', '${DateTime.now().month}');
                          await prefs.setString('name', name??'');
                          await prefs.setString('loc', location??'');
                          await prefs.setString('num', mobile??'');
                          await SharedPref.getMarketData();
                        }

                      },
                      child: const Text('Log in'))
                ],
            ),
          ),
        ),
    );
  }
}
