import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';
import 'package:sante_pour_tous/src/global/local/fiches/antecedant_local.dart';
import 'package:sante_pour_tous/src/global/local/fiches/conclusion_local.dart';
import 'package:sante_pour_tous/src/global/local/fiches/examen_local.dart';
import 'package:sante_pour_tous/src/global/local/fiches/identite_local.dart';
import 'package:sante_pour_tous/src/models/fiches/antecedant_fiche_model.dart';
import 'package:sante_pour_tous/src/models/fiches/conclusion_fiche_model.dart';
import 'package:sante_pour_tous/src/models/fiches/examen_fiche_model.dart';
import 'package:sante_pour_tous/src/models/fiches/identite_fiche_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/pages/fiches/antecedant/add_antecedant_fiche.dart';
import 'package:sante_pour_tous/src/pages/fiches/conclusion/add_conclusion_fiche.dart';
import 'package:sante_pour_tous/src/pages/fiches/examen/add_examen_fiche.dart';
import 'package:sante_pour_tous/src/pages/fiches/identite/update_identite_fiche.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';
import 'package:sante_pour_tous/src/widgets/title_widget.dart';

class DetailIdentiteFiche extends StatefulWidget {
  const DetailIdentiteFiche({Key? key, this.id}) : super(key: key);
  final int? id;

  @override
  State<DetailIdentiteFiche> createState() => _DetailIdentiteFicheState();
}

class _DetailIdentiteFicheState extends State<DetailIdentiteFiche> {
  final ScrollController _controllerScroll = ScrollController();
  bool isOpenAntecedant = false;
  bool isOpenExamen = false;
  bool isOpenConclution = false;

  List<AntecedantFicheModel> antecedantDataList = [];
  List<ExamentFicheModel> examentDataList = [];
  List<ConclusionFicheModel> conclusionDataList = [];

  AntecedantFicheModel? antecedantData;
  ExamentFicheModel? examentData;
  ConclusionFicheModel? conclusionData;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    final antecedant = await AntecedantLocal().getAllData();
    final examen = await ExamenLocal().getAllData();
    final conclusion = await ConclusionLocal().getAllData();
    if (!mounted) return;
    setState(() {
      if (antecedant.isNotEmpty) {
        antecedantData = antecedant
            .firstWhere((element) => element.identifiant == widget.id!);
      }
      if (examen.isNotEmpty) {
        examentData =
            examen.firstWhere((element) => element.identifiant == widget.id!);
        print('examentData $examentData');
      }
      if (conclusion.isNotEmpty) {
        conclusionData = conclusion
            .firstWhere((element) => element.identifiant == widget.id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<IdentiteFicheModel>(
            future: IdentiteLocal().getOneData(widget.id!),
            builder: (BuildContext context,
                AsyncSnapshot<IdentiteFicheModel> snapshot) {
              if (snapshot.hasData) {
                IdentiteFicheModel? data = snapshot.data;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppbar(title: "ID ${data!.id}"),
                    Expanded(
                        child: Scrollbar(
                            controller: _controllerScroll,
                            isAlwaysShown: true,
                            child: ListView(
                              controller: _controllerScroll,
                              children: [
                                dataWidget(data),
                                if (antecedantData != null)
                                  dataAntecedantWidget(antecedantData!),
                                if (examentData != null)
                                  dataExamenWidget(examentData!),
                                if (conclusionData != null)
                                  dataConclusionWidget(conclusionData!)
                              ],
                            )))
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  Widget dataWidget(IdentiteFicheModel data) {
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TitleWidget(title: data.preNom),
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  tooltip: 'Antecedant',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddAntecedantFiche(
                                                    identiteFicheModel: data)));
                                  },
                                  icon: Icon(Icons.history_edu,
                                      color: Colors.orange.shade700)),
                              IconButton(
                                  tooltip: 'Examen',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddExamenFiche(
                                                    identiteFicheModel: data)));
                                  },
                                  icon: Icon(Icons.badge,
                                      color: Colors.green.shade700)),
                              IconButton(
                                  tooltip: 'Consultaion',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddConclusionFiche(
                                                    identiteFicheModel: data)));
                                  },
                                  icon: Icon(Icons.border_color,
                                      color: Colors.purple.shade700)),
                              IconButton(
                                  tooltip: 'Modifier',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateIdentiteFiche(
                                                    identiteFicheModel: data)));
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
                                  "Créé le. ${DateFormat("dd-MM-yy").format(data.created)}",
                                  textAlign: TextAlign.end,
                                  style: bodyMedium),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  identiteWidget(data),
                  infosWidget(data)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget identiteWidget(IdentiteFicheModel ficheModel) {
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
                child: Text(ficheModel.nom,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Post-Nom :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.postNom,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Prénom :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.preNom,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Genre :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.sexe,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Age :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.age,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Taille :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.taille,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Poids :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.poids,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('TA :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.tensionArterielle,
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
                child: Text(ficheModel.email,
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
                child: Text(ficheModel.telephone,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Nom du père :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.nomPere,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Nom de la Mère :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.nomMere,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Province d\'origine :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.provinceOrigine,
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
                child: Text(ficheModel.adresse,
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

  Widget infosWidget(IdentiteFicheModel ficheModel) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Container(
      padding: const EdgeInsets.only(top: p16, bottom: p16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0),
          // bottom: BorderSide(width: 1.0),
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

  Widget dataAntecedantWidget(AntecedantFicheModel data) {
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
            child: ExpansionTile(
              collapsedBackgroundColor: Colors.orange.shade700,
              backgroundColor: Colors.orange.shade700,
              title: Text("Dossier Antécédant",
                  style: bodyMedium),
              leading: const Icon(Icons.folder_special, size: 30.0),
              initiallyExpanded: false,
              onExpansionChanged: (val) {
                setState(() {
                  isOpenAntecedant = !val;
                });
              },
              children: [
                  Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      personnelWidget(data),
                      medocoChirurgieWidget(data),
                      gynecoObstretiqueWidget(data),
                      infosAntecedantWidget(data)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget personnelWidget(AntecedantFicheModel ficheModel) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Container(
      padding: const EdgeInsets.all(p16),
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
              Text('Antécédent personnel :',
                  textAlign: TextAlign.start,
                  style: bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade700)),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Réligion :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.religion,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Etat civil :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.etatCivil,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Passion :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.passion,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Tumbaku Ya zolo :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text((ficheModel.tumbakuYazolo) ? 'Oui' : 'Non',
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

  Widget medocoChirurgieWidget(AntecedantFicheModel ficheModel) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Container(
      padding: const EdgeInsets.all(p16),
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
              Text('Antécédent Medico chirurgicaux :',
                  textAlign: TextAlign.start,
                  style: bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade700)),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Allergies :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text((ficheModel.allergies) ? 'OUI' : 'NON',
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              ),
              if (ficheModel.allergies)
                Expanded(
                  child: Text(ficheModel.allergiesText,
                      textAlign: TextAlign.start,
                      style: Responsive.isDesktop(context)
                          ? bodyMedium
                          : bodyText1),
                )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('ISTA :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text((ficheModel.ista) ? 'OUI' : 'NON',
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Diabete :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text((ficheModel.diabete) ? 'OUI' : 'NON',
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Tabac :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text((ficheModel.tabac) ? 'OUI' : 'NON',
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Alcool :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text((ficheModel.alcool) ? 'OUI' : 'NON',
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Produits Appreritifs :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text((ficheModel.produitsApperitifs) ? 'OUI' : 'NON',
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              ),
              if (ficheModel.produitsApperitifs)
                Expanded(
                  child: Text(ficheModel.produitsApperitifsText,
                      textAlign: TextAlign.start,
                      style: Responsive.isDesktop(context)
                          ? bodyMedium
                          : bodyText1),
                )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Consultation Neuro Phsychiatrique :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(
                    (ficheModel.consultationNeuroPhsychiatrique)
                        ? 'OUI'
                        : 'NON',
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              ),
              if (ficheModel.consultationNeuroPhsychiatrique)
                Expanded(
                  child: Text(ficheModel.consultationNeuroPhsychiatriqueText,
                      textAlign: TextAlign.start,
                      style: Responsive.isDesktop(context)
                          ? bodyMedium
                          : bodyText1),
                )
            ],
          ),
        ],
      ),
    );
  }

  Widget gynecoObstretiqueWidget(AntecedantFicheModel ficheModel) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Container(
      padding: const EdgeInsets.all(p16),
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
              Text('Gyneco Obstretrique :',
                  textAlign: TextAlign.start,
                  style: bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade700)),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('DDR :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(DateFormat("dd-MM-yy").format(ficheModel.ddr),
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Parite(P) :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.parite,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Geste Nombre Grossesse(G) :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.gesteNbreGrossesse,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('NombreAvortement(A) :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.nbreAvortement,
                    textAlign: TextAlign.start,
                    style:
                        Responsive.isDesktop(context) ? bodyMedium : bodyText1),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Age du dernier enfant(DE) :',
                    textAlign: TextAlign.start,
                    style: Responsive.isDesktop(context)
                        ? bodyMedium.copyWith(fontWeight: FontWeight.bold)
                        : bodyText1!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(ficheModel.ageDernierEnfant,
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

  Widget infosAntecedantWidget(AntecedantFicheModel ficheModel) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Container(
      padding: const EdgeInsets.all(p16),
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

  Widget dataExamenWidget(ExamentFicheModel data) {
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
            child: ExpansionTile(
              collapsedBackgroundColor: Colors.green.shade700,
              backgroundColor: Colors.green.shade700,
              leading: const Icon(Icons.folder_zip, size: 30.0),
              iconColor: Colors.white,
              title: Text("Dossier Exmamen",
                  style: bodyMedium!),
              initiallyExpanded: false,
              onExpansionChanged: (val) {
                setState(() {
                  isOpenExamen = !val;
                });
              },
              children: [
                Card(
                  elevation: 10,
                  child: Column(
                    children: [examenWidget(data), infosExamenWidget(data)],
                  ),
                ),
              ],
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
      padding: const EdgeInsets.all(p16),
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

  Widget infosExamenWidget(ExamentFicheModel ficheModel) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Container(
      padding: const EdgeInsets.all(p16),
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

  Widget dataConclusionWidget(ConclusionFicheModel data) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
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
          child: ExpansionTile(
            collapsedBackgroundColor: Colors.purple.shade700,
            backgroundColor: Colors.purple.shade700,
            title: Text("Dossier Conclusion",
                style: bodyMedium),
            leading: const Icon(Icons.rule_folder_rounded, size: 30.0),
            initiallyExpanded: false,
            onExpansionChanged: (val) {
              setState(() {
                isOpenConclution = !val;
              });
            },
            children: [
                Card(
                elevation: 10,
                child: Column(
                  children: [
                    conclusionWidget(data),
                    infosConclusionWidget(data)
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget conclusionWidget(ConclusionFicheModel ficheModel) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Container(
      padding: const EdgeInsets.all(p16),
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

  Widget infosConclusionWidget(ConclusionFicheModel ficheModel) {
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
