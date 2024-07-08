
import 'package:cat/features/category_details/view/pages/category_details.dart';
import 'package:cat/features/home_screen/view/pages/home_screen.dart';
import 'package:cat/features/home_screen/view/pages/oredrs_details_screen.dart';
import 'package:cat/features/maker/view/pages/pizza_maker.dart';
import 'package:cat/features/meal_screen/view/pages/meal_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
       // home: MyHomePage(),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName : (_) =>  const HomeScreen(),
          OrderDetailsScreen.routeName : (_) =>  const OrderDetailsScreen(),
         // CategoriesScreen.routeName : (_) =>  CategoriesScreen(),
          CategoryDetails.routeName : (_) =>  CategoryDetails(),
          MealScreen.routName : (_) =>  MealScreen(),
          PizzaMaker.routeName : (_) =>   PizzaMaker(),
        },
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("NEW"),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) => buildPopupDialog(context),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange, // Background color
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 130, vertical: 60),
//
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8)),
//               ),
//               child: const Row(children: [
//                 Icon(
//                   Icons.add,
//                   color: Colors.black,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   "Add category",
//                   style: TextStyle(color: Colors.black),
//                 )
//               ]),
//             )
//           ],
//         ),
//       ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }


