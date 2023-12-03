import 'dart:async';
import 'dart:typed_data';

import 'package:accounting/app/shared_pref.dart';
import 'package:accounting/consts.dart';
import 'package:accounting/domain_models/best_sellers/best_seller.dart';
import 'package:accounting/domain_models/expenses_model/expenses_model.dart';
import 'package:accounting/domain_models/product_model/product_model.dart';
import 'package:accounting/domain_models/fatorah_model/fatorah_model.dart';
import 'package:accounting/widgets/custom_textfield.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:printing/printing.dart';
import '../data_cubites/store_cubit/store_cubit.dart';
import '../domain_models/fatorah_model/fatorah_item_model/fatorah_item.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';


Future<void> openHiveBoxes()async{
  String path ='C:\\accounting_hive';
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(FatorahModelAdapter());
  Hive.registerAdapter(FatorahModelItemAdapter());
  Hive.registerAdapter(ExpensesModelAdapter());
  Hive.registerAdapter(BestSellerAdapter());
//path: path
  await Hive.openBox<ProductModel>(productsBox,);
  await Hive.openBox<BestSeller>(bestSeller,);
  await Hive.openBox<FatorahModel>(fatorahBox,);
  await Hive.openBox<FatorahModel>(deptsBox,);
  await Hive.openBox<ExpensesModel>(expensesBox,);

}

customSnackBar(String message,BuildContext context){
  final snackBar = SnackBar(
    margin: EdgeInsets.symmetric(vertical: 20.h),
    duration: const Duration(seconds: 4),
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: message,
      message: '',
      contentType: ContentType.help,
    ),
  );

  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
}

 addProductDialog(BuildContext context,Function add,) {
  Size size =MediaQuery.of(context).size;
  print(size);
  TextEditingController countController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  String? name, id, category='غير محدد';
  double buyingPrice = 0, sellPrice = 0, minCount = 0, packageCount = 0, packageItemsCount = 0, count = 0, availableSale = 0;
  if(size.width<745||size.height<535){
    return AlertDialog();
  }else {
    return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            title: Row(
              children: [
                const Text(
                  'اضافة منتج جديد للمخزن',
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            content: SizedBox(
              width: 1000.w,
              height: 350.h,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                          title: 'id',
                          onChange: (x) {
                            id = x;
                          },
                          validator: (x) {
                            if (x!.isEmpty) {
                              return 'مطلوب';
                            } else {
                              //Fun;
                              return null;
                            }
                          },
                        )),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                            child: CustomTextField(
                              title: 'اسم',
                          onChange: (x) {
                            name = x;
                          },
                          validator: (x) {
                            if (x!.isEmpty) {
                              return 'مطلوب';
                            } else {
                              //Fun;
                              return null;
                            }
                          },
                        )),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                            child: CustomTextField(
                              title: 'الفئه',
                          onChange: (x) => category = x,

                        )),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                              title: 'سعر الشراء',
                          onChange: (x) {
                            buyingPrice = double.tryParse(x) ?? 0;
                          },
                          validator: (x) {
                            if (double.tryParse(x!) == null) {
                              return 'من فضلك ادخل رقم صحيح';
                            } else {
                              //Fun;
                              return null;
                            }
                          },
                        )),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                            child: CustomTextField(
                              title: 'سعر البيع',
                          onChange: (x) {
                            sellPrice = double.tryParse(x!) ?? 0;
                          },
                          validator: (x) {
                            if (double.tryParse(x!) == null) {
                              return 'من فضلك ادخل رقم صحيح';
                            } else {
                              //Fun;
                              return null;
                            }
                          },
                        )),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                            child: CustomTextField(
                              title: 'اقل كميه',
                          onChange: (x) {
                            minCount = double.tryParse(x!) ?? 0;
                          },
                              validator: (x) {
                                if (x!.isNotEmpty) {
                                  if (double.tryParse(x!) == null) {
                                    return 'من فضلك ادخل رقم صحيح';
                                  } else {
                                    //Fun;
                                    return null;
                                  }
                                } else {
                                  return null;
                                }
                              },
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                              title: 'عدد المجموعات',
                          onChange: (x) {
                            packageCount = double.tryParse(x) ?? 0;
                          },
                          validator: (x) {
                            if (x!.isNotEmpty) {
                              if (double.tryParse(x!) == null) {
                                return 'من فضلك ادخل رقم صحيح';
                              } else {
                                //Fun;
                                return null;
                              }
                            } else {
                              return null;
                            }
                          },
                        )),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                            child: CustomTextField(
                              title: 'عدد العناصر بالمجموعه',
                          onChange: (x) {
                            packageItemsCount = double.tryParse(x) ?? 0;
                          },
                          validator: (x) {
                            if (x!.isNotEmpty) {
                              if (double.tryParse(x!) == null) {
                                return 'من فضلك ادخل رقم صحيح';
                              } else {
                                return null;
                              }
                            } else {
                              return null;
                            }
                          },
                        )),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                            child: CustomTextField(
                          controller: countController,
                          onTap: () {
                            if (packageCount != 0 && packageItemsCount != 0) {
                              count = packageItemsCount * packageCount;
                              countController.text = count.toString();
                            }
                          },
                              title: 'عدد القطع',
                          onChange: (x) {
                            count = double.tryParse(x!) ?? 0;
                          },
                          validator: (x) {
                            if (x!.isEmpty || double.tryParse(x!) == null) {
                              return 'من فضلك ادخل رقم صحيح';
                            } else {
                              return null;
                            }
                          },
                        )),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                            child: CustomTextField(
                              title: 'الخصم المتاح',
                          onChange: (x) {
                            availableSale = double.tryParse(x) ?? 0;
                          },
                          validator: (x) {
                            if (x!.isNotEmpty) {
                              if (double.tryParse(x!) == null) {
                                return 'من فضلك ادخل رقم صحيح';
                              } else {
                                //Fun;
                                return null;
                              }
                            } else {
                              return null;
                            }
                          },
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async{
                  if (formKey.currentState!.validate()) {
                    if(BlocProvider.of<StoreCubit>(context).productsIdList().contains(id)){
                      showDialog(context: context, builder: (context)=>AlertDialog(
                        content: Text('id موجود بالفعل \nمن فضلك ادخل رقم مختلف',style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.bold),),
                      ));
                    }else if(BlocProvider.of<StoreCubit>(context).productsNamesList().contains(name)){
                      showDialog(context: context, builder: (context)=>AlertDialog(
                        content: Text('هذا الاسم مستخدم مسبقا من فضلك ادخل اسم مختلف',style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.bold),),
                      ));
                    }else{
                      add(name, id, category, buyingPrice, sellPrice , minCount, packageCount , packageItemsCount, count, availableSale,DateTime.now());
                      Navigator.pop(context);
                      addProductDialog(context, add);
                    }
                  }
                },
                child: const Text('اضافه'),
              ),
            ],
          );
  }
}


printFatorah(FatorahModel fatorahModel)async{
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => printingWidget(format, fatorahModel));
}

FutureOr<Uint8List> printingWidget(PdfPageFormat format, FatorahModel fatorahModel) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: false);
  final font = await PdfGoogleFonts.alexandriaRegular();
  double fatTotal=0;
  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a6,
      textDirection: pw.TextDirection.rtl,
      margin: const pw.EdgeInsets.only(right: 150),
      build: (context) {
        return pw.Padding(
            padding: const pw.EdgeInsets.symmetric(
              horizontal: 4,
            ),
            child: pw.DefaultTextStyle(
              style: pw.TextStyle(font: font, fontSize: 7),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(SharedPref.name),
                        pw.Text(SharedPref.mobile),
                        pw.Text(SharedPref.location),
                      ]
                  ),
                  pw.SizedBox(height: 20),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('الاسم'),
                      pw.Text('العدد'),
                      pw.Text('السعر'),
                      pw.Text('اجمالي'),
                    ],
                  ),
                  pw.Divider(height: 10),
                  ...fatorahModel.fatorahProductsList
                      .map((e) {
                        String name=split(e.productName!,10),
                            count=split(e.count.toString(),4),
                            price=split(e.productPrice.toString(),4),
                            total=split((e.productPrice*e.count) .toString(),4);
                        fatTotal+= e.count * e.productPrice;
                        return pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 2),
                          child: pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(name),
                                pw.Text(count),
                                pw.Text(price),
                                pw.Text(total),
                              ])
                      );
                      }).toList(),
                  pw.Divider(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            if(fatTotal!=fatorahModel.fatorahTotal)pw.Text('المجموع :  $fatTotal'),
                            pw.SizedBox(height: 5),
                            if(fatTotal!=fatorahModel.fatorahTotal)pw.Text('خصم :  ${fatTotal-fatorahModel.fatorahTotal}'),
                            pw.SizedBox(height: 5),
                            pw.Text('الاجمالي :  ${fatorahModel.fatorahTotal}'),
                          ]
                      ),
                    ]
                  )
                ],
              ),
            ));
      }));
  return pdf.save();
}

split(String x,int len){
  String y='';
  for(int i=0; i<x.length; i++){
    if(i==0) {
      y += x[i];
      continue;
    }
    if(i%len != 0){
      y+=x[i];
    }else{
      y+=x[i];
      y+='\n';
    }
  }
  return y;
}
