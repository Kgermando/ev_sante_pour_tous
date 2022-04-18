import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';
import 'package:sante_pour_tous/src/global/local/fiches/antecedant_local.dart';
import 'package:sante_pour_tous/src/models/fiches/antecedant_fiche_model.dart';
import 'package:sante_pour_tous/src/navigation/header/custom_appbar.dart';
import 'package:sante_pour_tous/src/pages/fiches/antecedant/update_antecedant_fiche.dart';
import 'package:sante_pour_tous/src/widgets/print_widget.dart';

class DetailAntecedantFiche extends StatefulWidget {
  const DetailAntecedantFiche({Key? key, this.id}) : super(key: key);
  final int? id;

  @override
  State<DetailAntecedantFiche> createState() => _DetailAntecedantFicheState();
}

class _DetailAntecedantFicheState extends State<DetailAntecedantFiche> {
  final ScrollController _controllerScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Row(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.all(p10),
              child: FutureBuilder<AntecedantFicheModel>(
                  future: AntecedantLocal().getOneData(widget.id!),
                  builder: (BuildContext context,
                      AsyncSnapshot<AntecedantFicheModel> snapshot) {
                    if (snapshot.hasData) {
                      AntecedantFicheModel? data = snapshot.data;
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
                  })),
        ),
      ],
    )));
  }

  Widget dataWidget(AntecedantFicheModel data) {
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  tooltip: 'Modifier',
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => UpdateAntecedantFiche(
                                            antecedantFicheModel: data)));
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
                                  "Créé le. ${DateFormat("dd-MM-yy HH:mm").format(data.createdAntecedant)}",
                                  textAlign: TextAlign.end,
                                  style: bodyMedium),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  personnelWidget(data),
                  medocoChirurgieWidget(data),
                  gynecoObstretiqueWidget(data),
                  infosWidget(data)
                ],
              ),
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

  Widget infosWidget(AntecedantFicheModel ficheModel) {
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