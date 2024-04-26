import 'package:cat/core/data_base/models/meal_model.dart';
import 'package:cat/core/data_base/my_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_ingredient_state.dart';

class AddIngredientCubit extends Cubit<AddIngredientState> {
  AddIngredientCubit() : super(AddIngredientInitial());
  addIngredient({
    required String categoryId,
    required String mealId,
    required IngredientsModel ingredientsModel
  })async{
    emit(AddIngredientLoading());
    try{
     await MyDataBase.addIngredients(
          ingredientsModel: ingredientsModel,
          categoryId: categoryId
          , mealId: mealId
      );
     emit(AddIngredientSuccess());
    }on FirebaseException catch(e){
      emit( AddIngredientFailure(e.message??"Error"));
    }catch(e){
      emit( AddIngredientFailure(e.toString()));
    }
  }
}
