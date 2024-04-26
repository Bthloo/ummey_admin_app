import 'dart:io';
import 'package:cat/core/data_base/models/meal_model.dart';
import 'package:cat/core/general_components/build_show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../viewmodel/add_meal/add_meal_cubit.dart';


class PopUpAddMeal extends StatefulWidget {
  const PopUpAddMeal({super.key,this.categoryId});
final String? categoryId;

  @override
  State<PopUpAddMeal> createState() => _PopUpAddCategoryState();
}

class _PopUpAddCategoryState extends State<PopUpAddMeal> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  AddMealCubit addMealCubit = AddMealCubit();
  File? _image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      File? img = File(image.path);
      img = await cropImage(imageFile: img);
      setState(() {
        _image = img;
        // Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      buildShowToast(e.message??"Error");
      // Navigator.of(context).pop();
    }
  }

  Future<File?> cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
    await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Meal'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () {
                pickImage();
              },
              child: Container(
                color: Colors.white54,
                width: double.infinity,
                height: 100.h,
                child: _image == null ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add photo",
                        style: TextStyle(color: Colors.black),
                      )
                    ]
                )
                    : Image(
                  image: FileImage(_image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || _image == null) {
                          return "Please Enter Name and Image";
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Meal name',
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || _image == null) {
                          return "Please Enter Description";
                        } else {
                          return null;
                        }
                      },
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Meal Description',
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || _image == null) {
                          return "Please Enter Price";
                        } else {
                          return null;
                        }
                      },
                      controller: priceController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Meal Price',
                      ),
                    ),
                    SizedBox(height: 5.h,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        BlocConsumer<AddMealCubit, AddMealState>(
          bloc:  addMealCubit,
          listener: (context, state) {
            if(state is  AddMealSuccess){
              Navigator.pop(context);
              buildShowToast(state.message);
            }else if(state is  AddMealFailed){
              buildShowToast(state.message);
            }
          },
          builder: (context, state) {
            if(state is  AddMealLoading){
              return const CircularProgressIndicator();
            }else{
              return ElevatedButton(
                onPressed: () {
                  addMeal(categoryId: widget.categoryId!);
                },
                child: const Text('DONE'),
              );
            }
          },
        ),
      ],
    );
  }

  addMeal({required String categoryId} ) {
    if (_formKey.currentState!.validate() == false) {
      return;
    } else {
      addMealCubit.addMeal(
        categoryId: categoryId,
        mealName: nameController.text,
          mealModel: MealModel(
            price: priceController.text,
            name: nameController.text,
            description: descriptionController.text
          ),
          image: _image!
      );
    }
  }
}

