import 'package:flutter/material.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget(
      {Key? key,
      required this.selected,
      this.selectedTileColor,
      required this.icon,
      required this.title,
      required this.onTap,
      required this.style,
      required this.sizeIcon, this.badge})
      : super(key: key);

  final bool selected;
  final Color? selectedTileColor;
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final TextStyle style;
  final double sizeIcon;
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    Color? colorCard;
    if (selected == true) {
      colorCard = themeColor;
    }
    Color? color;
    if (selected == true) {
      color = Colors.white;
    }
    return Card(
      color: colorCard,
      child: ListTile(
        // selected: selected,
        // selectedColor: color,
        // selectedTileColor: selectedTileColor,
        dense: true,
        leading: Icon(icon,
            size: sizeIcon,
            // color: color,
            color: color),
        title: Text(title, style: style.copyWith(color: color)),
        trailing: badge,
        onTap: onTap,
        style: ListTileStyle.drawer,
      ),
    );
  }
}
