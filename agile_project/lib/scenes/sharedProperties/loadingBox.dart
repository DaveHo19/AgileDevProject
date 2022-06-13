import 'package:agile_project/constants.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 20,
          color: kPrimaryLightColor,
        ),
      ),
    );
  }
}