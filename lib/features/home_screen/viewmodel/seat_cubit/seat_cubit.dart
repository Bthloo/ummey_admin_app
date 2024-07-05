import 'package:bloc/bloc.dart';
import 'package:cat/core/data_base/my_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/data_base/models/seat_model.dart';

part 'seat_state.dart';

class SeatCubit extends Cubit<SeatState> {
  SeatCubit() : super(SeatInitial());
  static SeatCubit get(context) => BlocProvider.of(context);

  List<SeatModel> allSeats = [];
  List<SeatModel> reservedSeats = [];
  List<SeatModel> emptySeats = [];
  getSeats()async{
     allSeats = [];
     reservedSeats = [];
     emptySeats = [];
    emit(SeatLoading());
    try{
      var getDataCollection = await MyDataBase.getSeatsCollection();
      var getList = await getDataCollection.get();
      getList.docs.forEach((element) {
        allSeats.add(element.data());
        if(element.data().isReserved == true){
          reservedSeats.add(element.data());
        }else{
          emptySeats.add(element.data());
        }
      },);
      emit(SeatSuccess());
    }catch(e){
      emit(SeatError(e.toString()));
    }
  }
}
