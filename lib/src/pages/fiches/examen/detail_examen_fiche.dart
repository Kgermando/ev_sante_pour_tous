import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';
import 'package:sante_pour_tous/src/global/local/fiches/examen_local.dart';
import 'package:sante_pour_tous/src/models/fiches/examen_fiche_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/pages/fiches/examen/update_examen_fiche.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';
import 'package:sante_pour_tous/src/widgets/title_widget.dart';

class DetailExamenFiche extends StatefulWidget {
  const DetailExamenFiche({Key? key, this.id}) : super(key: key);
  final int? id;

  @override
  State<DetailExamenFiche> createState() => _DetailExamenFicheState();
}

class _DetailExamenFicheState extends State<DetailExamenFiche> {
  final ScrollController _controllerScroll = ScrollController();

   @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<ExamentFicheModel>(
            future: ExamenLocal().getOneData(widget.id!),
            builder: (BuildContext context,
                AsyncSnapshot<ExamentFicheModel> snapshot) {
              if (snapshot.hasData) {
                ExamentFicheModel? data = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppbar(title: 'ID ${data!.identifiant}'),
                    Expanded(
                        child: Scrollbar(
                            controller: _controllerScroll,
                            isAlwaysShown: true,
                            child: dataWidget(data)))
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  Widget dataWidget(ExamentFicheModel data) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(p8),
          child: Container(
            width: (Responsive.isDesktop(context))
              ? MediaQuery.of(context).size.width / 1.5
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const TitleWidget(title: "Examen realiser"),
                      Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    tooltip: 'Modifier',
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateExamenFiche(
                                                  examentFicheModel: data)));
                                    },
                                    icon: const Icon(Icons.edit)),
                                  PrintWidget(
                                    tooltip: 'Imprimer le document',
                                    onPressed: () {})     
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  "Créé le. ${DateFormat("dd-MM-yy HH:mm").format(data.createdExamen)}",
                                  textAlign: TextAlign.end,
                                  style: bodyMedium),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  examenWidget(data),
                  infosWidget(data)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget examenWidget(ExamentFicheModel ficheModel) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Container(
      padding: const EdgeInsets.only(top: p16, bottom: p16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0),
          bottom: BorderSide(width: 1.0),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Groupe Sanguin :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.groupSanguin,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Resus :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text((ficheModel.resus) ? "Positif" : "Negatif",
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('HBS :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.hbs,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Electro phoreuse Hb :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.electrophoreuseHb,
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

  Widget infosWidget(ExamentFicheModel ficheModel) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Container(
      padding: const EdgeInsets.only(top: p16, bottom: p16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0),
          bottom: BorderSide(width: 1.0),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Statut :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              if (ficheModel.statut == "En attente")
                Expanded(
                  child: Text(ficheModel.statut,
                      textAlign: TextAlign.start,
                      style: Responsive.isDesktop(context)
                          ? bodyMedium!.copyWith(color: Colors.red.shade700)
                          : bodyText1!.copyWith(color: Colors.red.shade700)),
                ),
              if (ficheModel.statut == "Près pour examen")
                Expanded(
                  child: Text(ficheModel.statut,
                      textAlign: TextAlign.start,
                      style: Responsive.isDesktop(context)
                          ? bodyMedium!.copyWith(color: Colors.orange.shade700)
                          : bodyText1!.copyWith(color: Colors.orange.shade700)),
                ),
              if (ficheModel.statut == "Près")
                Expanded(
                  child: Text(ficheModel.statut,
                      textAlign: TextAlign.start,
                      style: Responsive.isDesktop(context)
                          ? bodyMedium!.copyWith(color: Colors.blue.shade700)
                          : bodyText1!.copyWith(color: Colors.blue.shade700)),
                ),
              if (ficheModel.statut == "Ok")
                Expanded(
                  child: Text(ficheModel.statut,
                      textAlign: TextAlign.start,
                      style: Responsive.isDesktop(context)
                          ? bodyMedium!.copyWith(color: Colors.green.shade700)
                          : bodyText1!.copyWith(color: Colors.green.shade700)),
                )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Signature :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.signature,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Institut :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.institut,
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