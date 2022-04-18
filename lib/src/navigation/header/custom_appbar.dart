import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';
import 'package:sante_pour_tous/src/models/menu_item.dart';
import 'package:sante_pour_tous/src/navigation/header/header_item.dart';
import 'package:sante_pour_tous/src/utils/menu_items.dart';
import 'package:sante_pour_tous/src/utils/menu_options.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CustomAppbarState createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  bool isActiveNotification = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Responsive.isDesktop(context) ? p10 : p30),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => Routemaster.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              HeaderItem(title: widget.title),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.email)
                ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications )),
              
              PopupMenuButton<MenuItem>(
                onSelected: (item) => MenuOptions().onSelected(context, item),
                itemBuilder: (context) => [
                  ...MenuItems.itemsFirst.map(MenuOptions().buildItem).toList(),
                  const PopupMenuDivider(),
                  ...MenuItems.itemsSecond.map(MenuOptions().buildItem).toList(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
