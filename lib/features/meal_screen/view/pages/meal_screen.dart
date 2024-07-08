import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat/features/category_details/view/pages/category_details.dart';
import 'package:cat/features/meal_screen/viewmodel/meal_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/data_base/models/meal_model.dart';
import '../../../../core/general_components/build_show_toast.dart';
import '../../add_ingredient_cubit.dart';

class MealScreen extends StatelessWidget {
  MealScreen({super.key});
  static const String routName = "item-screen";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final AddIngredientCubit addIngredientCubit = AddIngredientCubit();
  final _formKey = GlobalKey<FormState>();
  BuildContext? getIngredientContext;

  @override
  Widget build(BuildContext context) {
    MealScreenArgument argument =
        ModalRoute.of(context)!.settings.arguments as MealScreenArgument;
    return Scaffold(
      appBar: AppBar(
        title: Text(argument.mealModel.name!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 200.h,
                width: double.infinity,
                color: Colors.orange,
                padding: const EdgeInsets.all(10),
                child: CachedNetworkImage(
                  imageUrl: argument.mealModel.imageUrl!,
                  //fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                          Text(
                            argument.mealModel.name!.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Text(
                            "${argument.mealModel.price!} LE",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),

                      SizedBox(
                        height: 30.h,
                      ),
                      Text(argument.mealModel.description!,
                          style: const TextStyle(
                            fontSize: 19,
                          ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Gradients:",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('New Ingredient'),
                                    content: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 14),
                                      child: Form(
                                        key: _formKey,
                                        child: SizedBox(
                                          height: MediaQuery.of(context).size.height*.3,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please Enter Name";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                controller: nameController,
                                                decoration:
                                                    const InputDecoration(
                                                  border:
                                                      UnderlineInputBorder(),
                                                  labelText: 'Ingredient name',
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please Enter Number";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                controller: numberController,
                                                decoration:
                                                    const InputDecoration(
                                                  border:
                                                      UnderlineInputBorder(),
                                                  labelText:
                                                      'Ingredient Number',
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      BlocConsumer<AddIngredientCubit,
                                          AddIngredientState>(
                                        bloc: addIngredientCubit,
                                        listener: (context, state) {
                                          if (state is AddIngredientSuccess) {
                                            Navigator.pop(context);
                                            buildShowToast(
                                                "Added Successfully");
                                          } else if (state
                                              is AddIngredientFailure) {
                                            buildShowToast(state.message);
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state is AddIngredientLoading) {
                                            return const CircularProgressIndicator();
                                          } else {
                                            return ElevatedButton(
                                              onPressed: () {
                                                addIngredient(
                                                    categoryId:
                                                        argument.categoryID,
                                                    mealId: argument
                                                        .mealModel.id!,
                                                    ingredientsModel:
                                                        IngredientsModel(
                                                            number:
                                                                numberController
                                                                    .text,
                                                            title:
                                                                nameController
                                                                    .text));
                                              },
                                              child: const Text('DONE'),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ).then((value){
                                if(nameController.text.isNotEmpty&&numberController.text.isNotEmpty){
                                  nameController.clear();
                                  numberController.clear();
                                  MealScreenCubit.get(getIngredientContext).getMeals(
                                    categoryId: argument.categoryID,
                                    mealId: argument.mealModel.id!,
                                  );
                                }
                              });
                            },
                            icon: const Icon(Icons.add_circle))
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 200.h,
                      child: BlocProvider(
                        create: (context) => MealScreenCubit()
                          ..getMeals(
                            categoryId: argument.categoryID,
                            mealId: argument.mealModel.id!,
                          ),
                        child: BlocBuilder<MealScreenCubit, MealScreenState>(
                          builder: (context, state) {
                            getIngredientContext = context;
                            if (state is MealScreenLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is MealScreenFailed) {
                              return Center(child: Text(state.message));
                            } else if (state is MealScreenSuccess) {
                              if (state.ingredients.isEmpty) {
                                return const Center(
                                    child: Text("No Ingredient Yet"));
                              } else {
                                return ListView.separated(
                                    itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                              "${state.ingredients[index].data().title}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.w500)),
                                          Text(
                                              "X ${state.ingredients[index].data().number}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.w500)),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const Divider(),
                                    itemCount: state.ingredients.length);
                              }
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
      // bottomSheet: Row(
      //   children: [
      //     const SizedBox(
      //       width: 5,
      //     ),
      //     ElevatedButton(
      //         onPressed: () {},
      //         child: const Row(
      //           children: [
      //             Text(
      //               "Add to cart",
      //               style: TextStyle(fontSize: 20),
      //             ),
      //             SizedBox(
      //               width: 10,
      //             ),
      //             Icon(CupertinoIcons.cart)
      //           ],
      //         )),
      //
      //     //plus and minus
      //     const SizedBox(
      //       width: 40,
      //     ),
      //     IconButton(
      //         onPressed: () {}, icon: const Icon(CupertinoIcons.plus_app_fill)),
      //     const SizedBox(
      //       width: 10,
      //     ),
      //     const Text(
      //       "1",
      //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //     ),
      //     const SizedBox(
      //       width: 10,
      //     ),
      //     IconButton(
      //         onPressed: () {},
      //         icon: const Icon(CupertinoIcons.minus_rectangle_fill)),
      //   ],
      // ),
    );
  }

  addIngredient(
      {required String categoryId,
      required String mealId,
      required IngredientsModel ingredientsModel}) {
    if (_formKey.currentState!.validate() == false) {
      return;
    } else {
      addIngredientCubit.addIngredient(
          categoryId: categoryId,
          mealId: mealId,
          ingredientsModel: ingredientsModel);
    }
  }
}
