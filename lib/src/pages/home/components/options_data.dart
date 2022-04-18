import 'package:flutter/material.dart';
import 'package:sante_pour_tous/src/pages/fiches/antecedant/list_antecedant_fiche.dart';
import 'package:sante_pour_tous/src/pages/fiches/conclusion/list_conclusion_fiche.dart';
import 'package:sante_pour_tous/src/pages/fiches/examen/list_examen_fiche.dart';
import 'package:sante_pour_tous/src/pages/fiches/identite/list_identite_fiche.dart';
import 'package:sante_pour_tous/src/pages/fiches/stats_fiche.dart';

class OptionData {
  final String title;
  final Color color;
  final Widget tap;
  final IconData icons;

  OptionData(
      {required this.title,
      required this.color,
      required this.tap,
      required this.icons});
}

List<OptionData> dataMenu = [
  OptionData(
    title: 'Statisques', 
    color: Colors.amberAccent.shade700, 
    tap: const StatsFiche(), 
    icons: Icons.pie_chart_rounded
  ),
  OptionData(
      title: 'Identités',
      color: Colors.blue.shade700,
      tap: const ListIdentiteFiche(),
      icons: Icons.group),
  OptionData(
      title: 'Antécedant',
      color: Colors.orange.shade700,
      tap: const ListAntecedantFiche(),
      icons: Icons.history_edu),
  OptionData(
      title: 'Examens',
      color: Colors.green.shade700,
      tap: const ListExamenFiche(),
      icons: Icons.badge),
  OptionData(
      title: 'Conclusions',
      color: Colors.purple.shade700,
      tap: const ListConclusionFiche(),
      icons: Icons.border_color),
];
