import 'package:flutter/material.dart';

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category name"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(context),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Background color
                padding:
                const EdgeInsets.symmetric(horizontal: 130, vertical: 60),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Row(children: [
                Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Add item",
                  style: TextStyle(color: Colors.black),
                )
              ]),
            )
          ],
        ),
      ),

    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('New item'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Background color
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 60),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Column(children: [
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
            ])),

        //name
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Item name',
            ),
          ),
        ),

        //price
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Item Price',
            ),
          ),
        ),

        //des
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Item Des',
            ),
          ),
        ),
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('DONE'),
      ),
    ],
  );
}


