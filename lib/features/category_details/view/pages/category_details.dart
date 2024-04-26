import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat/core/data_base/models/categories_model.dart';
import 'package:cat/features/category_details/viewmodel/get_meals_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/data_base/models/meal_model.dart';
import '../../../../core/general_components/ColorHelper.dart';
import '../../../meal_screen/view/pages/meal_screen.dart';
import '../components/add_meal_pop_up.dart';

class CategoryDetails extends StatelessWidget {
  CategoryDetails({super.key});
  static const String routeName = "categoryDetails";

  //GetMealsCubit getMealsCubit = GetMealsCubit();
  BuildContext? getMealsContext;

  @override
  Widget build(BuildContext context) {
    var argument = ModalRoute.of(context)!.settings.arguments as CategoryModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(argument.name ?? "rrr"),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.orange,
            width: double.infinity,
            height: 150.h,
            child: CachedNetworkImage(
                fit: BoxFit.contain, imageUrl: argument.url!),
          ),
          ListTile(
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => PopUpAddMeal(
                    categoryId: argument.id,
                  ),
                ).then((value) => GetMealsCubit.get(getMealsContext).getMeals(argument.id!));
              },
            ),
            title: Text(
              "Meals",
              style: TextStyle(
                  fontSize: 25.sp,
                  color: ColorHelper.mainColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          BlocProvider(
            create: (context) => GetMealsCubit()..getMeals(argument.id!),
            child: BlocBuilder<GetMealsCubit, GetMealsState>(
              // bloc: getMealsCubit,
              builder: (context, state) {
                getMealsContext= context;
                if (state is GetMealsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetMealsFailure) {
                  return Center(child: Text("Error ${state.message}"));
                } else if (state is GetMealsSuccess) {
                  if (state.data.isEmpty) {
                    return const Center(child: Text("There are no Meals Yet"));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              Navigator.pushNamed(context, MealScreen.routName,
                                  arguments: MealScreenArgument(
                                      mealModel: state.data[index].data(),
                                      categoryID: argument.id!));
                              // await MyDataBase.addIngredients(
                              //     ingredientsModel: IngredientsModel(
                              //         title: "ing 1",
                              //         number: "4"
                              //     ),
                              //     categoryId: argument.id,
                              //     mealId: "1oTJ3RHWpbCGIR3v7jPe");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    color: Colors.orange),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      state.data[index].data().name ??
                                          "No Name",
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                    Text(
                                      "${state.data[index].data().price} LE",
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return const Center(child: Text("ffff"));
                }
              },
            ),
          )
        ],
      ),
    );
  }

  List<IngredientsModel> ingredients = [
    IngredientsModel(title: "in 1", number: "4"),
    IngredientsModel(title: "in 2", number: "2"),
    IngredientsModel(title: "in 3", number: "3"),
  ];
}

class MealScreenArgument {
  String categoryID;
  MealModel mealModel;
  MealScreenArgument({required this.mealModel, required this.categoryID});
}
