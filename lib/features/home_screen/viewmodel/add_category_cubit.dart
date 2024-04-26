import 'dart:async';
import 'dart:io';
import 'package:cat/core/data_base/models/categories_model.dart';
import 'package:cat/core/data_base/my_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit() : super(AddCategoryInitial());
  final storageRef = FirebaseStorage.instance.ref();
  String imageUrl = "";
  addCategory({required CategoryModel categoryModel, required File image,required String categoryName})async{
    emit(AddCategoryLoading());
    try{
      final imageRef = storageRef.child("images");
      final refranceToUpload = imageRef.child(categoryName);
      await refranceToUpload.putFile(File(image.path));
      imageUrl = await refranceToUpload.getDownloadURL();
      debugPrint(imageUrl);
      categoryModel.url = imageUrl;
      await MyDataBase.addCategory(categoryModel);
      emit(AddCategorySuccess("success"));
    }on FirebaseException catch(e){
      emit(AddCategoryFailed(e.toString()));
    }on TimeoutException catch(e){
      emit(AddCategoryFailed(e.toString()));
    }
    catch(e){
      emit(AddCategoryFailed(e.toString()));

    }

  }
}
