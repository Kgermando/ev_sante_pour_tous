import 'package:flutter/material.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/widgets/bar_chart_widget.dart';
import 'package:sante_pour_tous/src/widgets/pie_chart_widget.dart';

class StatsFiche extends StatefulWidget {
  const StatsFiche({Key? key}) : super(key: key);

  @override
  State<StatsFiche> createState() => _StatsFicheState();
}

class _StatsFicheState extends State<StatsFiche> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppbar(title: 'Statistiques'),
          Expanded(
            child: Wrap(
              children: const [
                Card(
                  elevation: 10,
                  child: PieChartWidget()
                ),
                Card(
                  elevation: 10,
                  child: BarChartWidget()
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
