import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/global/local/universite/universite_local.dart';
import 'package:sante_pour_tous/src/models/universites/universite_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/pages/admin/universite/update_universite.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';
import 'package:sante_pour_tous/src/widgets/title_widget.dart';

import '../../../constants/responsive.dart';

class DetailUniversite extends StatefulWidget {
  const DetailUniversite({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<DetailUniversite> createState() => _DetailUniversiteState();
}

class _DetailUniversiteState extends State<DetailUniversite> {
  final ScrollController _controllerScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UniversiteModel>(
          future: UniversiteLocal().getOneData(widget.id),
          builder: (BuildContext context,
              AsyncSnapshot<UniversiteModel> snapshot) {
            if (snapshot.hasData) {
              UniversiteModel? universiteModel = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppbar(title: 'Université'),
                  Expanded(
                      child: Scrollbar(
                          controller: _controllerScroll,
                          isAlwaysShown: true,
                          child: dataWidget(universiteModel!)))
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }));
  }


  Widget dataWidget(UniversiteModel universiteModel) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(p8),
          child: Container(
            width: (Responsive.isDesktop(context))
                ? MediaQuery.of(context).size.width / 2
                : MediaQuery.of(context).size.width / 1.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(p10),
              border: Border.all(
                color: Colors.blueGrey.shade700,
                width: 2.0,
              ),
            ),
            child: Card(
              elevation: 10,
              child: ListView(
                controller: _controllerScroll,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleWidget(title: universiteModel.name),
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  tooltip: 'Modifier',
                                  onPressed: () {
                                     Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => UpdateUniversite(universiteModel: universiteModel)));
                                  },
                                  icon: const Icon(Icons.edit)),
                              PrintWidget(
                                  tooltip: 'Imprimer le document',
                                  onPressed: () {})
                            ],
                          ),
                          Text(
                              "Créé le. ${DateFormat("dd-MM-yy").format(universiteModel.created)}",
                              textAlign: TextAlign.start,
                              style: bodyMedium),
                        ],
                      )
                    ],
                  ),
                  identiteWidget(universiteModel),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget identiteWidget(UniversiteModel universiteModel) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Container(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Nom :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(universiteModel.name,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Nom complet :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(universiteModel.sousNom,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Pays :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(universiteModel.pays,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Province :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(universiteModel.province,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Email :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(universiteModel.email,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Téléphone :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(universiteModel.telephone,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Site web :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(universiteModel.siteweb,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Adresse :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(universiteModel.adresse,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
        ],
      ),
    );
  }
}
