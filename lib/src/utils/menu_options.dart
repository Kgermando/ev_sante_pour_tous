import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sante_pour_tous/src/global/local/users/auth_local.dart';
import 'package:sante_pour_tous/src/models/menu_item.dart';
import 'package:sante_pour_tous/src/routes/routes.dart';
import 'package:sante_pour_tous/src/utils/menu_items.dart';

class MenuOptions with ChangeNotifier {
  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
      value: item,
      child: Row(
        children: [
          Icon(item.icon, size: 20),
          const SizedBox(width: 12),
          Text(item.text)
        ],
      ));

  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemProfile:
        Routemaster.of(context).push(UserRoutes.profile);
        break;

      case MenuItems.itemHelp:
        Routemaster.of(context).push(UserRoutes.helps);
        break;

      case MenuItems.itemSettings:
        Routemaster.of(context).push(UserRoutes.settings);
        break;

      case MenuItems.itemLogout:
        Routemaster.of(context).replace(UserRoutes.login);
        // Remove stockage jwt here.
        AuthLocal().logout();
        Routemaster.of(context).replace(UserRoutes.login);
    }
  }
}
