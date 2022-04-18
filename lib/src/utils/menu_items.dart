import 'package:flutter/material.dart';
import 'package:sante_pour_tous/src/models/menu_item.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [
    itemProfile,
    itemHelp,
    itemSettings,
  ];

  static const List<MenuItem> itemsSecond = [
    itemLogout,
  ];

  static const itemProfile = MenuItem(
    text: 'Profil',
    icon: Icons.person,
  );

  static const itemHelp = MenuItem(text: 'Aide', icon: Icons.help);

  static const itemSettings = MenuItem(
    text: 'Settings',
    icon: Icons.settings,
  );

  static const itemLogout = MenuItem(text: 'Déconnexion', icon: Icons.logout);
}

