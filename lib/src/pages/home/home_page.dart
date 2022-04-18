import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/global/local/universite/universite_local.dart';
import 'package:sante_pour_tous/src/models/universites/universite_model.dart';
import 'package:sante_pour_tous/src/pages/home/options_page.dart';
import 'package:sante_pour_tous/src/routes/routes.dart';

import '../../navigation/header/custom_appbar.dart';
import '../../utils/loading.dart';

final _lightColors = [
  Colors.blue.shade700,
  Colors.amber.shade700,
  Colors.red.shade700,
  Colors.lightGreen.shade700,
  Colors.lightBlue.shade700,
  Colors.orange.shade700,
  Colors.pink.shade700,
  Colors.teal.shade700,
  Colors.orange.shade700,
  Colors.green.shade700,
  Colors.purple.shade700,
  Colors.brown.shade700,
  Colors.blue.shade700,
  Colors.grey.shade700,
  Colors.blueGrey.shade700,
  Colors.deepOrange.shade700,
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controllerTwo = ScrollController();
  Timer? timer;

  @override
  initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      loadData();
    });

    super.initState();
  }

  @override
  dispose() {
    timer!.cancel();
    super.dispose();
  }

  int nombreCampaign = 0;

  Future loadData() async {
    final dataList = await UniversiteLocal().getAllData();
    setState(() {
      nombreCampaign = dataList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.school),
            onPressed: () {
              Routemaster.of(context).push(AdminRoutes.tableUniv);
            }),
        body: Column(
          children: [
            const CustomAppbar(title: 'Univeristés'),
            const SizedBox(height: p20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Routemaster.of(context).push(UserRoutes.users);
                  }, 
                  icon: const Icon(
                    Icons.admin_panel_settings,
                    color: Colors.red,
                  ),
                  label: const Text('Users', style: TextStyle(color: Colors.red))),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
                  child: AutoSizeText(
                    'Vous avez $nombreCampaign dossiers',
                    style: headline6!.copyWith(color: Colors.teal),
                  ),
                )
              ],
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FutureBuilder<List<UniversiteModel>>(
                        future: UniversiteLocal().getAllData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<UniversiteModel>> snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Quelque chose c'est mal passée");
                          }

                          if (snapshot.hasData) {
                            List<UniversiteModel>? universites = snapshot.data;
                            return universites!.isEmpty
                                ? const Center(
                                    child: Text('Pas encore de dossier'),
                                  )
                                : Scrollbar(
                                    controller: _controllerTwo,
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      children: List.generate(
                                        universites.length,
                                        (index) {
                                          final universite =
                                              universites[index];
                                          final color = _lightColors[
                                              index % _lightColors.length];
                                          return dossierCard(
                                              universite, color);
                                        },
                                      ),
                                    ));
                          }
                          return loading();
                        }),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget dossierCard(UniversiteModel universiteModel, Color color) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Column(
      children: [
        Card(
          elevation: 10,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OptionsPage(universiteModel: universiteModel)));
            },
            child: Container(
              width: 150,
              height: 150,
              color: color,
              padding: const EdgeInsets.all(8.0),
              child: const Icon(
                Icons.folder_shared,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
            width: 150,
            child: Text(
              universiteModel.name.toUpperCase(),
              textAlign: TextAlign.center,
              style: headline6!.copyWith(fontSize: 14.0),
              overflow: TextOverflow.visible,
            ))
      ],
    );
  }
}
