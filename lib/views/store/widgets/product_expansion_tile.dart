import 'package:accounting/domain_models/product_model/product_model.dart';
import 'package:accounting/views/store/widgets/product_update_changes.dart';
import 'package:accounting/views/store/widgets/titles_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/app_colors.dart';
import '../../../data_cubites/store_cubit/store_cubit.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/widgets_fun.dart';

bool admin = true;

class ProductExpansionTile extends StatelessWidget {
  const ProductExpansionTile({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    var storeCubit = BlocProvider.of<StoreCubit>(context);
    List<ProductModel> searchProductsList = storeCubit.searchProductsList;
    GlobalKey<FormState> key = GlobalKey();
    TextEditingController nameController = TextEditingController();
    TextEditingController buyingPriceController = TextEditingController();
    TextEditingController sellPriceController = TextEditingController();
    TextEditingController minCountController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    TextEditingController idController = TextEditingController();
    TextEditingController availableSaleController = TextEditingController();
    TextEditingController packageCountController = TextEditingController();
    TextEditingController packageItemsCountController = TextEditingController();
    TextEditingController countController = TextEditingController();

    idController.text = searchProductsList[index].id.toString();
    nameController.text = searchProductsList[index].name!;
    categoryController.text = searchProductsList[index].category.toString();
    buyingPriceController.text =
        searchProductsList[index].buyingPrice.toString();
    sellPriceController.text = searchProductsList[index].sellPrice.toString();
    minCountController.text = searchProductsList[index].minCount.toString();
    availableSaleController.text =
        searchProductsList[index].availableSale.toString();
    packageCountController.text =
        searchProductsList[index].packageCount.toString();
    packageItemsCountController.text =
        searchProductsList[index].packageItemsCount.toString();
    countController.text = searchProductsList[index].count.toString();
      return Form(
        key: key,
        child: ExpansionTile(
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: searchProductsList[index].count == 0  || searchProductsList[index].count == searchProductsList[index].minCount?
              Colors.pink.shade200
                  : Colors.transparent,
            ),
            padding: const EdgeInsets.all(10),
            child: TitlesRow(
                id: idController.text,
                price: sellPriceController.text,
                name: nameController.text,
                count: countController.text,
                isTitle: false),
          ),
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    title: 'id',
                    controller: idController,
                    validator: (x) {
                      if (x!.isEmpty) {
                        return 'مطلوب';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 60,
                ),
                Expanded(
                    child: CustomTextField(
                      title: 'اسم',
                      controller: nameController,
                      validator: (x) {
                        if (x!.isEmpty) {
                          return 'مطلوب';
                        } else {
                          //Fun;
                          return null;
                        }
                      },
                    )),
                const SizedBox(
                  width: 60,
                ),
                Expanded(
                  child: CustomTextField(
                    title: 'الفئه',
                    controller: categoryController,
                    validator: (x) {
                      if (x!.isEmpty) {
                        return 'مطلوب';
                      } else {
                        //Fun;
                        return null;
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                if (admin)
                  Expanded(
                    child: CustomTextField(
                      title: 'سعر الشراء',
                      controller: buyingPriceController,
                      validator: (x) {
                        if (double.tryParse(x!) == null) {
                          return 'من فضلك ادخل رقم صحيح';
                        } else {
                          //Fun;
                          return null;
                        }
                      },
                    ),
                  ),
                if (admin)
                  const SizedBox(
                    width: 60,
                  ),
                Expanded(
                  child: CustomTextField(
                    title: 'سعر البيع',
                    controller: sellPriceController,
                    validator: (x) {
                      if (double.tryParse(x!) == null) {
                        return 'من فضلك ادخل رقم صحيح';
                      } else {
                        //Fun;
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 60,
                ),
                Expanded(
                  child: CustomTextField(
                    title: 'اقل كميه',
                    controller: minCountController,
                    validator: (x) {
                      if (x!.isNotEmpty) {
                        if (double.tryParse(x!) == null) {
                          return 'من فضلك ادخل رقم صحيح';
                        } else {
                          //Fun;
                          return null;
                        }
                      } else {
                        return 'مطلوب';
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    title: 'عدد المجموعات',
                    controller: packageCountController,
                    validator: (x) {
                      if (x!.isNotEmpty) {
                        if (double.tryParse(x!) == null) {
                          return 'من فضلك ادخل رقم صحيح';
                        } else {
                          //Fun;
                          return null;
                        }
                      } else {
                        return 'مطلوب';
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 60,
                ),
                Expanded(
                  child: CustomTextField(
                    title: 'عدد العناصر بالمجموعه',
                    controller: packageItemsCountController,
                    validator: (x) {
                      if (x!.isNotEmpty) {
                        if (double.tryParse(x!) == null) {
                          return 'من فضلك ادخل رقم صحيح';
                        } else {
                          //Fun;
                          return null;
                        }
                      } else {
                        return 'مطلوب';
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 60,
                ),
                Expanded(
                  child: CustomTextField(
                    title: 'عدد القطع',
                    controller: countController,
                    onTap: () {
                      double packageCount =
                          double.tryParse(packageCountController.text) ?? 0;
                      double packageItemsCount =
                          double.tryParse(packageItemsCountController.text) ?? 0;
                      if (packageCount != 0 && packageItemsCount != 0) {
                        var count = packageItemsCount * packageCount;
                        countController.text = count.toString();
                      }
                    },
                    validator: (x) {
                      if (x!.isEmpty || double.tryParse(x!) == null) {
                        return 'من فضلك ادخل رقم صحيح';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 60,
                ),
                Expanded(
                  child: CustomTextField(
                    title: 'خصم متاح',
                    controller: availableSaleController,
                    validator: (x) {
                      if (x!.isNotEmpty) {
                        if (double.tryParse(x!) == null) {
                          return 'من فضلك ادخل رقم صحيح';
                        } else {
                          //Fun;
                          return null;
                        }
                      } else {
                        return 'مطلوب';
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Spacer(),
                Text(
                  '${dayFormat(searchProductsList[index].storingDate)}',
                  style: TextStyle(fontSize: 16.sp, color: AppColors.black),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: admin
                        ? () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title:
                          const Text('هل انت متأكد من حذف هذا العنصر!'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  storeCubit.deleteProduct(
                                      searchProductsList[index]
                                          .id
                                          .toString());
                                  Navigator.pop(context);
                                },
                                child: const Text('نعم')),
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('لا')),
                          ],
                        ),
                      );
                    }
                        : null,
                    child: const Text('حذف من المخزن')),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    onPressed: admin
                        ? () {
                      if (key.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            if ((idController.text ==
                                searchProductsList[index].id! ||
                                !storeCubit
                                    .productsIdList()
                                    .contains(idController.text)) &&
                                (!storeCubit
                                    .productsNamesList()
                                    .contains(nameController.text) ||
                                    searchProductsList[index].name ==
                                        nameController.text)) {
                              return ProductUpdateChanges(
                                currentId: searchProductsList[index].id!,
                                id: idController.text,
                                name: nameController.text,
                                category: categoryController.text,
                                buy: double.parse(
                                    buyingPriceController.text),
                                sell:
                                double.parse(sellPriceController.text),
                                gomla:
                                double.parse(minCountController.text),
                                packageCount: double.parse(
                                    packageCountController.text),
                                packageItemsCount: double.parse(
                                    packageItemsCountController.text),
                                count: double.parse(countController.text),
                                availableSale: double.parse(
                                    availableSaleController.text),
                                dateTime: searchProductsList[index].count !=
                                    double.parse(countController.text)
                                    ? DateTime.now()
                                    : searchProductsList[index].storingDate,
                                function: storeCubit.updateProduct,
                              );
                            } else if (storeCubit
                                .productsNamesList()
                                .contains(nameController.text) &&
                                nameController.text !=
                                    searchProductsList[index].name) {
                              return AlertDialog(
                                title: const Text('الاسم موجود بالفعل'),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context),
                                      child: Text('اغلاق'))
                                ],
                              );
                            } else {
                              return AlertDialog(
                                title: const Text('موجود بالفعل id'),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context),
                                      child: Text('اغلاق'))
                                ],
                              );
                            }
                          },
                        );
                      }
                    }
                        : null,
                    child: const Text('تعديل')),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      );
  }
}
