import 'package:cat/core/general_components/ColorHelper.dart';
import 'package:cat/features/category_details/view/pages/category_details.dart';
import 'package:cat/features/home_screen/viewmodel/get_category/get_categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../component/category_item.dart';
import '../component/pop_up_category.dart';

class CategoriesScreen extends StatelessWidget {
   CategoriesScreen({super.key});

 // static const routeName = 'home-screen';

  BuildContext? getCategoryContext;
  @override
  Widget build(BuildContext context) {
    // getCategoriesCubit.getCategories();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text("Yummy Admin App",style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => const PopUpAddCategory(),
                  ).then((value) {
                    GetCategoriesCubit.get(getCategoryContext).getCategories();
                  });
                },
              ),
              title: Text(
                "Categories",
                style: TextStyle(
                    fontSize: 25.sp,
                    color: ColorHelper.mainColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            BlocProvider(
              create: (context) => GetCategoriesCubit()..getCategories(),
              child: BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
                //bloc: getCategoriesCubit,
                builder: (context, state) {
                  getCategoryContext = context;
                  if (state is GetCategoriesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetCategoriesFailure) {
                    return Center(child: Text("Error ${state.message}"));
                  } else if (state is GetCategoriesSuccess) {
                    if (state.categories.isEmpty) {
                      return const Center(child: Text("No categories"));
                    } else {
                      return Expanded(
                          child: Wrap(
                            children: state.categories
                                .map((item) => InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, CategoryDetails.routeName,
                                    arguments: item.data());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CategoryItem(
                                  name: item.data().name!,
                                  imageUrl: item.data().url ?? '',
                                ),
                              ),
                            ))
                                .toList(),
                          )
                        // ListView.builder(
                        //   itemCount: state.categories.length,
                        //     scrollDirection: Axis.horizontal,
                        //     itemBuilder: (context, index) {
                        //       return Padding(
                        //         padding: const EdgeInsets.all(5.0),
                        //         child: CategoryItem(
                        //           name:state.categories[index].data().name! ,
                        //           imageUrl: state.categories[index].data().url??'',
                        //         ),
                        //       );
                        //     },
                        // ),
                      );
                    }
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

