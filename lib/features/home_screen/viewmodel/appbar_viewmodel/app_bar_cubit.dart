import 'package:cat/features/home_screen/view/pages/categories_screen.dart';
import 'package:cat/features/home_screen/view/pages/discount_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../maker/view/pages/maker.dart';
import '../../view/pages/admin_cart.dart';
part 'app_bar_state.dart';
class BottomAppBarCubit extends Cubit<BottomAppBarState> {
  BottomAppBarCubit() : super(BottomAppBarInitial());
  static BottomAppBarCubit get(context) => BlocProvider.of(context);
  int currentTapIndex = 0;
  List<Widget> tabs = [
    CategoriesScreen(),
    //Maker(),
     DiscountPage(),
    const AdminCart(),
  ];
  void changeIndex(int index) {
    currentTapIndex = index;
    emit(ChangeBottomAppbarState());
  }
}
