import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/data_base/models/meal_model.dart';
import '../../../../core/data_base/my_database.dart';
part 'add_meal_state.dart';

class AddMealCubit extends Cubit<AddMealState> {
  AddMealCubit() : super(AddMealInitial());
  final storageRef = FirebaseStorage.instance.ref();
  String imageUrl = "";
  addMeal(
      {required MealModel mealModel,
        required File image,
        required String mealName,
        required String categoryId}
      )async{
    emit(AddMealLoading());
    try{
      final imageRef = storageRef.child("images");
      final refranceToUpload = imageRef.child(mealName);
      await refranceToUpload.putFile(File(image.path));
      imageUrl = await refranceToUpload.getDownloadURL();
     mealModel.imageUrl = imageUrl;
      await MyDataBase.addMeal(categoryId: categoryId,mealModel: mealModel);
      emit(AddMealSuccess("success"));
    }on FirebaseException catch(e){
      emit(AddMealFailed(e.toString()));
    }on TimeoutException catch(e){
      emit(AddMealFailed(e.toString()));
    }
    catch(e){
      emit(AddMealFailed(e.toString()));

    }

  }
}
