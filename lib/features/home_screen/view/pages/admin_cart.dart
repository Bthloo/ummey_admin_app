import 'package:cat/core/general_components/ColorHelper.dart';
import 'package:cat/features/home_screen/view/pages/oredrs_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewmodel/get_orders/get_orders_cubit.dart';

class AdminCart extends StatelessWidget {
  const AdminCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Orders"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocProvider(
            create: (context) => GetOrdersCubit()..getOrders(),
            child: BlocBuilder<GetOrdersCubit, GetOrdersState>(
              builder: (context, state) {
                if (state is GetOrdersLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetOrdersSuccess) {
                  var cubit = GetOrdersCubit.get(context);
                  if(state.orders.isEmpty) {
                    return const Center(child: Text("No Orders"));
                  }else{
                  return  DefaultTabController(
                        length: 4,
                        child: Scaffold(
                          appBar: const TabBar(
                            dividerColor: Colors.transparent,

                            tabAlignment: TabAlignment.start,
                            indicatorColor: ColorHelper.mainColor,
                            labelColor: ColorHelper.mainColor,
                            isScrollable: true,
                            //  controller: TabController(length: 4, vsync: ScrollableState()),
                              tabs: [
                                Tab(text: "All Orders",),
                                Tab(text: "Pending Orders",),
                                Tab(text: "On Delivery Orders",),
                                Tab(text: "Delivered Orders",),
                              ]
                          ),
                          body: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TabBarView(

                               // controller: TabController(length: 4, vsync: ScrollableState()),
                                children: [
                                  ListView.separated(
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: ColorHelper.mainColor,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: ListTile(
                                            onTap: (){
                                              Navigator.pushNamed(
                                                  context,
                                                  OrderDetailsScreen.routeName,
                                                  arguments: state.orders[index].data()
                                              );
                                            },
                                            title: Text("Name: ${state.orders[index].data().userName}",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),),
                                            subtitle: Text("${state.orders[index].data().cartModelList!.length} in cart",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),),
                                            trailing: Text("${state.orders[index].data().totalPrice} LE",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider();
                                      },
                                      itemCount: cubit.orders.length
                                  ),
                                  cubit.pendingOrders.isNotEmpty ?
                                  ListView.separated(
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: ColorHelper.mainColor,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: ListTile(
                                            onTap: (){
                                              Navigator.pushNamed(
                                                  context,
                                                  OrderDetailsScreen.routeName,
                                                  arguments: cubit.pendingOrders[index].data()
                                              );
                                            },
                                            title: Text("Name: ${cubit.pendingOrders[index].data().userName}",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),),
                                            subtitle: Text("${cubit.pendingOrders[index].data().cartModelList!.length} in cart",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),),
                                            trailing: Text("${cubit.pendingOrders[index].data().totalPrice} LE",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider();
                                      },
                                      itemCount: cubit.pendingOrders.length
                                  ):
                                  const Center(child: Text("No Pending Orders")),
                                  cubit.onDeliveryOrders.isNotEmpty ?
                                  ListView.separated(
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: ColorHelper.mainColor,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: ListTile(
                                            onTap: (){
                                              Navigator.pushNamed(
                                                  context,
                                                  OrderDetailsScreen.routeName,
                                                  arguments: cubit.onDeliveryOrders[index].data()
                                              );
                                            },
                                            title: Text("Name: ${cubit.onDeliveryOrders[index].data().userName}",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),),
                                            subtitle: Text("${cubit.onDeliveryOrders[index].data().cartModelList!.length} in cart",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),),
                                            trailing: Text("${cubit.onDeliveryOrders[index].data().totalPrice} LE",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider();
                                      },
                                      itemCount: cubit.onDeliveryOrders.length
                                  ):
                                  const Center(child: Text("No On Delivery Orders")),
                                  cubit.deliveredOrders.isNotEmpty ?
                                  ListView.separated(
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: ColorHelper.mainColor,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: ListTile(
                                            onTap: (){
                                              Navigator.pushNamed(
                                                  context,
                                                  OrderDetailsScreen.routeName,
                                                  arguments: cubit.deliveredOrders[index].data()
                                              );
                                            },
                                            title: Text("Name: ${cubit.deliveredOrders[index].data().userName}",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),),
                                            subtitle: Text("${cubit.deliveredOrders[index].data().cartModelList!.length} in cart",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),),
                                            trailing: Text("${cubit.deliveredOrders[index].data().totalPrice} LE",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider();
                                      },
                                      itemCount: cubit.deliveredOrders.length
                                  ):
                                  const Center(child: Text("No Delivered Orders"))
                                  ,
                                ]),
                          ),
                        )
                    );
                  }

                } else if (state is GetOrdersFailure) {
                  return Center(child: Text(state.error));
                } else {
                  return const Text("unknown state");
                }
              }
              ),
          ),
        )
    );
  }
}
