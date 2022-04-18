import 'package:flutter/material.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    final headline6 = Theme.of(context).textTheme.headline6;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style:  Responsive.isDesktop(context) 
            ? headlineMedium!.copyWith(fontWeight: FontWeight.bold)
            : headline6!.copyWith(fontWeight: FontWeight.bold)
        ),
        const SizedBox(height: p20,)
      ],
    );
  }
}
