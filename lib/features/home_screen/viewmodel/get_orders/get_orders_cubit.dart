import 'package:bloc/bloc.dart';
import 'package:cat/core/data_base/my_database.dart';
import 'package:cat/features/home_screen/view/pages/admin_cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/data_base/models/admin_cart_model.dart';

part 'get_orders_state.dart';

class GetOrdersCubit extends Cubit<GetOrdersState> {
  GetOrdersCubit() : super(GetOrdersInitial());
  static GetOrdersCubit get(context) => BlocProvider.of(context);
  List<QueryDocumentSnapshot<CartAmdinModel>> orders = [];
  List<QueryDocumentSnapshot<CartAmdinModel>> pendingOrders = [];
  List<QueryDocumentSnapshot<CartAmdinModel>> onDeliveryOrders = [];
  List<QueryDocumentSnapshot<CartAmdinModel>> deliveredOrders = [];
  getOrders()async{
    emit(GetOrdersLoading());
    orders = [];
    pendingOrders = [];
    onDeliveryOrders = [];
    deliveredOrders = [];
    try{

      MyDataBase.getCartAdminCollection().orderBy("time").snapshots().listen((event) {
        orders = [];
        pendingOrders = [];
        onDeliveryOrders = [];
        deliveredOrders = [];
        for (var element in event.docs) {
          orders.add(element);
          if(element.data().status == 'Pending') {
            pendingOrders.add(element);
          } else if(element.data().status == 'On Delivery'){
            onDeliveryOrders.add(element);
          } else if(element.data().status == 'Delivered'){
            deliveredOrders.add(element);}
        }
        emit(GetOrdersSuccess(orders));
      });

    }catch(e){
      GetOrdersFailure(e.toString());
    }
  }
}
