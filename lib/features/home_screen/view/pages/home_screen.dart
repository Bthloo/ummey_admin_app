import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/general_components/ColorHelper.dart';
import '../../viewmodel/appbar_viewmodel/app_bar_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
static const String routeName = "home-screen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomAppBarCubit(),
      child: BlocBuilder< BottomAppBarCubit, BottomAppBarState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: NavigationBar(
              selectedIndex: BottomAppBarCubit.get(context).currentTapIndex,
              onDestinationSelected: (value) {
                BottomAppBarCubit.get(context).changeIndex(value);
              },
              backgroundColor: ColorHelper.mainColor,
              indicatorColor: ColorHelper.darkColor,
              destinations: const [
                NavigationDestination(
                  selectedIcon: Icon(Icons.category, color: ColorHelper.mainColor,),
                  icon: Icon(Icons.category),
                  label: 'Categories'
                ),
                NavigationDestination(
                    selectedIcon: Icon(Icons.discount_outlined, color: ColorHelper.mainColor,),
                    icon: Icon(Icons.discount_outlined),
                    label: 'Discount'
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.shopping_cart_outlined, color: ColorHelper.mainColor,),
                  icon: Icon(Icons.shopping_cart_outlined),
                  label: 'Orders',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.event_seat, color: ColorHelper.mainColor,),
                  icon: Icon(Icons.event_seat),
                  label: 'Seats',
                ),
              ],
            ),
            appBar: AppBar(
                title:  Text("Ummey",style:  Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.mainColor,
                    //fontFamily: "Cairo"
                ),)
            ),
            body: BottomAppBarCubit.get(context).tabs
            [BottomAppBarCubit.get(context).currentTapIndex],
          );
        },
      ),
    );
  }
}
