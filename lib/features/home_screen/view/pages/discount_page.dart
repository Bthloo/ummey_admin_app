import 'package:cat/core/data_base/models/sale_model.dart';
import 'package:cat/core/data_base/my_database.dart';
import 'package:cat/core/general_components/build_show_toast.dart';
import 'package:cat/features/home_screen/viewmodel/get_discounts/get_discounts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscountPage extends StatelessWidget {
  DiscountPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController code = TextEditingController();
  final TextEditingController discount = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  BuildContext? cubitContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          showAddDiscountDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
        create: (context) =>
        GetDiscountsCubit()
          ..getDiscounts(),
        child: BlocBuilder<GetDiscountsCubit, GetDiscountsState>(
          builder: (context, state) {
            cubitContext = context;
            if(state is GetDiscountsLoading){
              return const Center(child: CircularProgressIndicator(),);
            }else if(state is GetDiscountsError){
              return Center(child: Text(state.message));
            }else if(state is GetDiscountsSuccess){
              if(state.discountModel.isEmpty){
                return const Center(child: Text('No Discount Codes Found'),);
              }
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.discountModel.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.orange,
                    child: ListTile(
                      
                      title: Text(state.discountModel[index].data().code.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(state.discountModel[index].data().discount.toString(),style: const TextStyle(
                        fontSize: 20,
                      ),),
                      trailing: Text(state.discountModel[index].data().quantity.toString(),style: const TextStyle(
                        fontSize: 20,
                      ),),
                    ),
                  );
                },
              );
            }else{
              return const Center(child: Text('Unknown State'),);
            }

          },
        ),
      ),
    );
  }

  showAddDiscountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(

          title: const Text('Add Discount'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: code,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please Enter Discount Code';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter Discount Code',
                  ),
                ),
                TextFormField(
                  controller: discount,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please Enter Discount Value';
                    }
                  //  else if (value.runtimeType != num) {
                   //   return 'Please Enter Valid Number';
                   // }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter Discount Value',
                  ),
                ),
                TextFormField(
                  controller: quantity,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please Enter Discount Quantity';
                    }
                      //  else if (value.runtimeType != int) {
                  //    return 'Please Enter Valid Number';
                   // }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter Discount Quantity',
                  ),
                ),

              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                addDiscount(
                    saleModel: SaleModel(
                        code: code.text,
                        discount: num.parse(discount.text),
                        quantity: int.parse(quantity.text)
                    ),
                  context: context,
                );
                //Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    ).then((value) {

      code.clear();
      discount.clear();
      quantity.clear();
      GetDiscountsCubit.get(cubitContext).getDiscounts();
    });

  }

  addDiscount({required SaleModel saleModel,required BuildContext context}) async {
    if (_formKey.currentState!.validate() == false) {
      return;
    } else {
      try {
        await MyDataBase.addDiscountCodes(saleModel).then((value) {
          Navigator.of(context).pop();
        });
        buildShowToast('Discount Added Successfully');
      } catch (e) {
        buildShowToast(e.toString());
      }
    }
  }


}
