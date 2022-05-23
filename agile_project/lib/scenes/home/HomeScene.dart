import 'package:flutter/material.dart';
import 'package:agile_project/models/enumList.dart';

class MyHomeScene extends StatefulWidget {
  const MyHomeScene({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomeScene> createState() => _MyHomeSceneState();
}

class _MyHomeSceneState extends State<MyHomeScene> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 2, childAspectRatio: 0.5),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: AssetImage(
                              'C:\Users\USER\Documents\GitHub\AgileDevProject\agile_project\assets\harryPotterCover.jpg')),
                      color: Colors.purple),
                ),
              ],
            );
          }),
    );
  }
}
