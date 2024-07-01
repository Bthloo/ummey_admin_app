import 'package:cat/features/maker/viewmodel/pizza_maker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PizzaMaker extends StatelessWidget {
   PizzaMaker({super.key});

  static const String routeName = "pizza-maker";

  final PageController pageController = PageController();

bool isToppingsSelected = false;
bool isCheeseSelected = false;
bool isSauceSelected = false;
bool isVegetablesSelected = false;
bool isCrustSelected = false;


int totalPrice = 0;
   final ValueNotifier<int> price = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                const SizedBox(width: 10,),
                ValueListenableBuilder<int>(
                    valueListenable: price,
                    builder: (context, value, _) {
                      return Text('$value',style: const TextStyle(fontSize: 20),);
                    },
                ),
                Spacer(),
                ElevatedButton(
                    onPressed: (){},
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.orange),

                  ),
                    child: const Padding(padding: EdgeInsets.symmetric(vertical: 4,horizontal: 4),
                      child: Text('Create ',style: TextStyle(fontSize: 20,color: Colors.black),),),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Pizza Maker',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.orange,
            ),
          ),
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            isScrollable: true,
            tabs: [
              Text("Toppings", style: TextStyle(
                fontSize: 20,

              ),),
              Text("Cheese", style: TextStyle(
                fontSize: 20,

              ),),
              Text("Sauce", style: TextStyle(
                fontSize: 20,

              ),),
              Text("Vegetables", style: TextStyle(
                fontSize: 20,

              ),),
              Text("Crust", style: TextStyle(
                fontSize: 20,

              ),),
            ],

          ),
        ),

        body: Padding(
          padding: EdgeInsets.all(10.0),
          child:  BlocProvider(
            create: (context) =>
            PizzaMakerCubit()
              ..getPizzaMaker(),
            child: BlocBuilder<PizzaMakerCubit, PizzaMakerState>(
              builder: (context, state) {
                if(state is PizzaMakerLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );}else if(state is PizzaMakerError) {
                  return Center(child: Text(state.message),);
                }else if(state is PizzaMakerLoaded){
                  var cubit = context.read<PizzaMakerCubit>();
                  return TabBarView(
                    children: [
                      Column(
                          children: [
                            SizedBox(height: 20,),

                            const Text("Select your Toppings",style: TextStyle(
                              fontSize: 30,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,

                            ),),
                            SizedBox(height: 20,),
                            Expanded(
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.pizzaMakerModel.toppings!.length,
                                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                     crossAxisCount: 3,
                                    crossAxisSpacing: 0,
                                     mainAxisSpacing: 0,
                                     mainAxisExtent: 40.h

                                     // childAspectRatio: 3 / 2,
                                    //  crossAxisSpacing: 10,
                                    //  mainAxisSpacing: 10
                                  ),
                                  itemBuilder: (context, index) {
                                    return StatefulBuilder(
                                      builder: (context, setStatee) {
                                        return ChoiceChip(
                                          selectedColor: Colors.orange,
                                          showCheckmark: false,
                                          onSelected: (value) {
                                            if(value){
                                              totalPrice += state.pizzaMakerModel.toppings![index].price!;
                                              price.value += state.pizzaMakerModel.toppings![index].price!;
                                            }else{
                                              totalPrice -= state.pizzaMakerModel.toppings![index].price!;
                                              price.value -= state.pizzaMakerModel.toppings![index].price!;
                                            }
                                            setStatee(() {
                                              cubit.isToppingSelected[index] = value;
                                            });
                                            debugPrint("Total Price: $totalPrice");
                                          },
                                          label: Text("${state.pizzaMakerModel.toppings![index].name}",style: const TextStyle(
                                            color: Colors.black,
                                          ),),
                                          selected: cubit.isToppingSelected[index],
                                        );
                                      },
                                    );
                                  },
                              ),
                            ),

                            // Wrap(
                            //   children: state.pizzaMakerModel.toppings!.map((e) {
                            //     return
                            //       Container(
                            //         margin: const EdgeInsets.all(5),
                            //         child: StatefulBuilder(
                            //           builder: (context, setStatee) {
                            //             return ChoiceChip(
                            //               selectedColor: Colors.orange,
                            //               showCheckmark: false,
                            //               onSelected: (value) {
                            //                 if(value){
                            //                   totalPrice += e.price!;
                            //                   price.value += e.price!;
                            //                 }else{
                            //                   totalPrice -= e.price!;
                            //                   price.value -= e.price!;
                            //                 }
                            //                 setStatee(() {
                            //                   isToppingsSelected = value;
                            //                 });
                            //                 debugPrint("Total Price: $totalPrice");
                            //               },
                            //               label: Text("${e.name}",style: const TextStyle(
                            //                 color: Colors.black,
                            //               ),),
                            //               selected: cubit.isToppingSelected[e],
                            //             );
                            //           },
                            //         ),
                            //       );
                            //   }).toList(),
                            //
                            // ),


                          ]
                      ),
                      Column(
                          children: [
                            const Text("Select your Cheese",style: TextStyle(
                              fontSize: 30,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,

                            ),),
                            Expanded(
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.pizzaMakerModel.cheeses!.length,
                                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    mainAxisExtent: 40.h

                                  // childAspectRatio: 3 / 2,
                                  //  crossAxisSpacing: 10,
                                  //  mainAxisSpacing: 10
                                ),
                                itemBuilder: (context, index) {
                                  return StatefulBuilder(
                                    builder: (context, setStatee) {
                                      return ChoiceChip(
                                        selectedColor: Colors.orange,
                                        showCheckmark: false,
                                        onSelected: (value) {
                                          if(value){
                                            totalPrice += state.pizzaMakerModel.cheeses![index].price!;
                                            price.value += state.pizzaMakerModel.cheeses![index].price!;
                                          }else{
                                            totalPrice -= state.pizzaMakerModel.cheeses![index].price!;
                                            price.value -= state.pizzaMakerModel.cheeses![index].price!;
                                          }
                                          setStatee(() {
                                            cubit.isCheeseSelected[index] = value;
                                          });
                                          debugPrint("Total Price: $totalPrice");
                                        },
                                        label: Text("${state.pizzaMakerModel.cheeses![index].name}",style: const TextStyle(
                                          color: Colors.black,
                                        ),),
                                        selected: cubit.isCheeseSelected[index],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),


                          ]
                      ),
                      Column(
                          children: [
                            const Text("Select your Sauce",style: TextStyle(
                              fontSize: 30,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,

                            ),),
                            Expanded(
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.pizzaMakerModel.sauces!.length,
                                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    mainAxisExtent: 40.h

                                  // childAspectRatio: 3 / 2,
                                  //  crossAxisSpacing: 10,
                                  //  mainAxisSpacing: 10
                                ),
                                itemBuilder: (context, index) {
                                  return StatefulBuilder(
                                    builder: (context, setStatee) {
                                      return ChoiceChip(
                                        selectedColor: Colors.orange,
                                        showCheckmark: false,
                                        onSelected: (value) {
                                          if(value){
                                            totalPrice += state.pizzaMakerModel.sauces![index].price!;
                                            price.value += state.pizzaMakerModel.sauces![index].price!;
                                          }else{
                                            totalPrice -= state.pizzaMakerModel.sauces![index].price!;
                                            price.value -= state.pizzaMakerModel.sauces![index].price!;
                                          }
                                          setStatee(() {
                                            cubit.isSauceSelected[index] = value;
                                          });
                                          debugPrint("Total Price: $totalPrice");
                                        },
                                        label: Text("${state.pizzaMakerModel.sauces![index].name}",style: const TextStyle(
                                          color: Colors.black,
                                        ),),
                                        selected: cubit.isSauceSelected[index],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),


                          ]
                      ),
                      Column(
                          children: [
                            const Text("Select your Vegetables",style: TextStyle(
                              fontSize: 30,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,

                            ),),
                            Expanded(
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.pizzaMakerModel.vegetables!.length,
                                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    mainAxisExtent: 40.h

                                  // childAspectRatio: 3 / 2,
                                  //  crossAxisSpacing: 10,
                                  //  mainAxisSpacing: 10
                                ),
                                itemBuilder: (context, index) {
                                  return StatefulBuilder(
                                    builder: (context, setStatee) {
                                      return ChoiceChip(
                                        selectedColor: Colors.orange,
                                        showCheckmark: false,
                                        onSelected: (value) {
                                          if(value){
                                            totalPrice += state.pizzaMakerModel.vegetables![index].price!;
                                            price.value += state.pizzaMakerModel.vegetables![index].price!;
                                          }else{
                                            totalPrice -= state.pizzaMakerModel.vegetables![index].price!;
                                            price.value -= state.pizzaMakerModel.vegetables![index].price!;
                                          }
                                          setStatee(() {
                                            cubit.isVegetablesSelected[index] = value;
                                          });
                                          debugPrint("Total Price: $totalPrice");
                                        },
                                        label: Text("${state.pizzaMakerModel.vegetables![index].name}",style: const TextStyle(
                                          color: Colors.black,
                                        ),),
                                        selected: cubit.isVegetablesSelected[index],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),


                          ]
                      ),
                      Column(
                          children: [
                            const Text("Select your Crust",style: TextStyle(
                              fontSize: 30,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,

                            ),),
                            Expanded(
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.pizzaMakerModel.crusts!.length,
                                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    mainAxisExtent: 40.h

                                  // childAspectRatio: 3 / 2,
                                  //  crossAxisSpacing: 10,
                                  //  mainAxisSpacing: 10
                                ),
                                itemBuilder: (context, index) {
                                  return StatefulBuilder(
                                    builder: (context, setStatee) {
                                      return ChoiceChip(
                                        selectedColor: Colors.orange,
                                        showCheckmark: false,
                                        onSelected: (value) {
                                          if(value){
                                            totalPrice += state.pizzaMakerModel.crusts![index].price!;
                                            price.value += state.pizzaMakerModel.crusts![index].price!;
                                          }else{
                                            totalPrice -= state.pizzaMakerModel.crusts![index].price!;
                                            price.value -= state.pizzaMakerModel.crusts![index].price!;
                                          }
                                          setStatee(() {
                                            cubit.isCrustSelected[index] = value;
                                          });
                                          debugPrint("Total Price: $totalPrice");
                                        },
                                        label: Text("${state.pizzaMakerModel.crusts![index].name}",style: const TextStyle(
                                          color: Colors.black,
                                        ),),
                                        selected: cubit.isCrustSelected[index],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),


                          ]
                      ),

                    ],
                  );



                }else{
                  return const SizedBox();
                }

              },
            ),
          )
        ),

      ),
    );
  }
}
