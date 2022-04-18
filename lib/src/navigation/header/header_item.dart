import 'package:flutter/material.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';

class HeaderItem extends StatelessWidget {
  const HeaderItem({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    final headline6 = Theme.of(context).textTheme.headline6;
    return Padding(
      padding: const EdgeInsets.only(left: p10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
          Text(
            title.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            style: headlineMedium
          ),
          
          if (!Responsive.isDesktop(context))
          Text(title.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            style: headline6
          ),
        ],
      )
    );
  }
}
