import 'package:flutter/material.dart';

class AppSpinner extends StatelessWidget {
  const AppSpinner({
    Key? key,
    this.width = 75,
    this.height = 75,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: const CircularProgressIndicator(),
        width: width,
        height: height,
      ),
    );
  }
}
