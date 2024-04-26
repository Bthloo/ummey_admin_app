import 'dart:io';

import 'package:cat/core/data_base/models/categories_model.dart';
import 'package:cat/core/general_components/build_show_toast.dart';
import 'package:cat/features/home_screen/viewmodel/add_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


class PopUpAddCategory extends StatefulWidget {
  const PopUpAddCategory({super.key});


  @override
  State<PopUpAddCategory> createState() => _PopUpAddCategoryState();
}

class _PopUpAddCategoryState extends State<PopUpAddCategory> {
  final TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AddCategoryCubit addCategoryCubit = AddCategoryCubit();
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
    debugPrint("build");
    return AlertDialog(
      title: const Text('New category'),
      content: Column(
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
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty || _image == null) {
                    return "Please Enter Name and Image";
                  } else {
                    return null;
                  }
                },
                controller: controller,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Category name',
                ),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        BlocConsumer<AddCategoryCubit, AddCategoryState>(
          bloc: addCategoryCubit,
          listener: (context, state) {
           if(state is AddCategorySuccess){
             Navigator.pop(context);
             buildShowToast(state.message??"");
           }else if(state is AddCategoryFailed){
             buildShowToast(state.message??"");
           }
          },
          builder: (context, state) {
            if(state is AddCategoryLoading){
              return const CircularProgressIndicator();
            }else{
              return ElevatedButton(
                onPressed: () {
                  addCategory();
                },
                child: const Text('DONE'),
              );
            }
          },
        ),
      ],
    );
  }

  addCategory() {
    if (_formKey.currentState!.validate() == false) {
      return;
    } else {
      addCategoryCubit.addCategory(
          categoryModel: CategoryModel(name: controller.text),
          categoryName:controller.text,
        image: _image!
      );
    }
  }
}

