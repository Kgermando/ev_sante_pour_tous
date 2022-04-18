import 'package:flutter/material.dart';

Widget loading() => Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: const [
    CircularProgressIndicator(color: Colors.white),
    SizedBox(width: 20.0),
    Text('Patientez svp...', style: TextStyle(color: Colors.white))
  ],
);


Widget loadingMini() => const CircularProgressIndicator(color: Colors.white);
