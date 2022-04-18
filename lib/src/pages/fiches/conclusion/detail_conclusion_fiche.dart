import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';
import 'package:sante_pour_tous/src/global/local/fiches/conclusion_local.dart';
import 'package:sante_pour_tous/src/models/fiches/conclusion_fiche_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/pages/fiches/conclusion/update_conclusion_fiche.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';

class DetailConclusionFiche extends StatefulWidget {
  const DetailConclusionFiche({Key? key, this.id}) : super(key: key);
  final int? id;

  @override
  State<DetailConclusionFiche> createState() => _DetailConclusionFicheState();
}

class _DetailConclusionFicheState extends State<DetailConclusionFiche> {
  final ScrollController _controllerScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<ConclusionFicheModel>(
            future: ConclusionLocal().getOneData(widget.id!),
            builder: (BuildContext context,
                AsyncSnapshot<ConclusionFicheModel> snapshot) {
              if (snapshot.hasData) {
                ConclusionFicheModel? data = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppbar(title: '${data!.identifiant}'),
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

  Widget dataWidget(ConclusionFicheModel data) {
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
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  tooltip: 'Modifier',
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => UpdateConclusionFiche(
                                            conclusionFicheModel: data)));
                                  },
                                  icon: const Icon(Icons.edit)),
                              PrintWidget(
                                  tooltip: 'Imprimer le document',
                                  onPressed: () {})
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  "Créé le. ${DateFormat("dd-MM-yy HH:mm").format(data.createdConsulsion)}",
                                  textAlign: TextAlign.end,
                                  style: bodyMedium),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  conclusionWidget(data),
                  infosWidget(data)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget conclusionWidget(ConclusionFicheModel ficheModel) {
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
              Text('Conclusion medicale :',
                  textAlign: TextAlign.start,
                  style: bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade700)),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(ficheModel.conclusion,
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

  Widget infosWidget(ConclusionFicheModel ficheModel) {
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