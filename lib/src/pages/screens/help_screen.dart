import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({ Key? key }) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: const [
        Center(child: Text("Page pas encore prête")),
      ],
    ));
  }
}