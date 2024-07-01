import 'package:cat/features/maker/view/pages/pizza_maker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Maker extends StatelessWidget {
  const Maker({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(Colors.white),
              backgroundColor: WidgetStateProperty.all(Colors.orange),
            ),
              onPressed: () {
                Navigator.pushNamed(context, PizzaMaker.routeName);
              },
              child: const Text('Make Pizza')
          ),
          ElevatedButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.white),
                backgroundColor: WidgetStateProperty.all(Colors.orange),
              ),
              onPressed: () {

              },
              child: const Text('Make Burger')
          )
        ],
      ),
    );
  }
}
