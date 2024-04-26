
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
   const CategoryItem({super.key,required this.imageUrl,required this.name});
 final String name;
   final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30.r,
          child:ClipOval(
            child: CachedNetworkImage(
                imageUrl: imageUrl,
              fit: BoxFit.fill,
            ),
          ),
        ),
         Text(name,style: const TextStyle(
          fontSize: 20,
        ),)
      ],
    );
  }
}
