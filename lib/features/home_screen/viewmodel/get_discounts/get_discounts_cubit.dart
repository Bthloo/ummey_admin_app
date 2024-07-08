import 'package:cat/core/data_base/my_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/data_base/models/sale_model.dart';

part 'get_discounts_state.dart';

class GetDiscountsCubit extends Cubit<GetDiscountsState> {
  GetDiscountsCubit() : super(GetDiscountsInitial());
  static GetDiscountsCubit get(context) => BlocProvider.of(context);
  List<QueryDocumentSnapshot<SaleModel>> discountModel = [];
  getDiscounts()async{
    emit(GetDiscountsLoading());
    try{
      QuerySnapshot<SaleModel> response = await MyDataBase.getDiscountCodes();
       emit(GetDiscountsSuccess(response.docs));
    }catch(e){
      emit(GetDiscountsError(e.toString()));
    }
  }
}
