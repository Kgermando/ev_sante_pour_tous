import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';

class DashboardCardWidget extends StatelessWidget {
  const DashboardCardWidget(
      {Key? key,
      required this.title,
      required this.icon,
      required this.montant,
      required this.color, required this.colorText})
      : super(key: key);
  final String title;
  final IconData icon;
  final String montant;
  final Color color;
  final Color colorText;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      shadowColor: color,
      child: Container(
        // width: size.width / 10,
        // height: size.height / 8,
        width: 200,
        height: 100,
        color: color,
        padding: const EdgeInsets.all(16.0 * 0.75),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  size: 20.0,
                  color: colorText
                ),
                AutoSizeText(
                  title,
                  style: Responsive.isDesktop(context) ? TextStyle(fontSize: 16, color: colorText) : TextStyle(fontSize: 10, color: colorText),
                  maxLines: 1,
                ),
                IconButton(icon: Icon(Icons.more_vert_outlined, color: colorText), onPressed: (){})
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  NumberFormat.decimalPattern('fr').format(double.parse(montant)),
                  style: Responsive.isDesktop(context)
                      ? TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold,
                          color: colorText)
                      : TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold,
                          color: colorText),
                  maxLines: 1,
                ),
                const SizedBox(width: 10.0),
                AutoSizeText(
                  '\$',
                  style: Responsive.isDesktop(context) 
                    ? TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorText)
                    : TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: colorText),
                  maxLines: 1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
