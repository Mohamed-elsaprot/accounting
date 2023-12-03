import 'package:accounting/app/app_colors.dart';
import 'package:accounting/data_cubites/store_cubit/store_state.dart';
import 'package:accounting/views/store/widgets/product_expansion_tile.dart';
import 'package:accounting/views/store/widgets/search_row.dart';
import 'package:accounting/views/store/widgets/titles_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data_cubites/store_cubit/store_cubit.dart';

class Store extends StatelessWidget {
  const Store({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var storeCubit= BlocProvider.of<StoreCubit>(context);
    Size size = MediaQuery.of(context).size;
    if(size.height>300 && size.width >400){
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchRow(),
              const SizedBox(
                height: 20,
              ),
              const TitlesRow(
                id: 'id',
                name: 'الاسم',
                price: 'السعر',
                count: 'الكميه',
                isTitle: true,
              ),
              SizedBox(height: 20.h,),
              BlocBuilder<StoreCubit,StoreState>(
                builder: (context,state){
                  return Expanded(
                    child: ListView.separated(
                      itemCount: storeCubit.searchProductsList.length,
                      itemBuilder: (context, index) {
                        return ProductExpansionTile(index: index,);
                      },
                      separatorBuilder: (context, index) => const Divider(
                          color: AppColors.black, thickness: .5, height: 40),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
    }else{
      return Text('حجم الشاشه غير مناسب',style: TextStyle(fontSize: 100.sp),);
    }
  }
}
