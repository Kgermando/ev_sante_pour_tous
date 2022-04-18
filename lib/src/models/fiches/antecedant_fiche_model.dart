import 'package:sembast/sembast.dart';

class AntecedantFicheModel {
  final int? id;
  final int identifiant; // filter sur l'id de l'identitéModel
  final String religion;
  final String etatCivil;
  final String passion;
  final bool tumbakuYazolo;
  final bool allergies;
  final String allergiesText;
  final bool ista;
  final bool diabete;
  final bool tabac;
  final bool alcool;
  final bool produitsApperitifs;
  final String produitsApperitifsText;
  final bool consultationNeuroPhsychiatrique;
  final String consultationNeuroPhsychiatriqueText;
  final DateTime ddr;
  final String parite;
  final String gesteNbreGrossesse;
  final String nbreAvortement;
  final String ageDernierEnfant;
  final String statut; // En attente ou ok
  final String signature;
  final String institut;
  final DateTime createdAntecedant;

  AntecedantFicheModel({
    this.id,
    required this.identifiant,
    required this.religion,
    required this.etatCivil,
    required this.passion,
    required this.tabac,
    required this.allergies,
    required this.allergiesText,
    required this.ista,
    required this.diabete,
    required this.tumbakuYazolo,
    required this.alcool,
    required this.produitsApperitifs,
    required this.produitsApperitifsText,
    required this.consultationNeuroPhsychiatrique,
    required this.consultationNeuroPhsychiatriqueText,
    required this.ddr,
    required this.parite,
    required this.gesteNbreGrossesse,
    required this.nbreAvortement,
    required this.ageDernierEnfant,
    required this.statut,
    required this.signature,
    required this.institut,
    required this.createdAntecedant,
  });

  factory AntecedantFicheModel.fromJson(Map<String, dynamic> json) {
    return AntecedantFicheModel(
      id: json['id'],
      identifiant: json["identifiant"],
      religion: json["religion"],
      etatCivil: json["etatCivil"],
      passion: json["passion"],
      tumbakuYazolo: json["tumbakuYazolo"],
      allergies: json["allergies"],
      allergiesText: json["allergiesText"],
      ista: json["ista"],
      diabete: json["diabete"],
      tabac: json["tabac"],
      alcool: json["alcool"],
      produitsApperitifs: json["produitsApperitifs"],
      produitsApperitifsText: json["produitsApperitifsText"],
      consultationNeuroPhsychiatrique: json["consultationNeuroPhsychiatrique"],
      consultationNeuroPhsychiatriqueText:
          json["consultationNeuroPhsychiatriqueText"],
      ddr: DateTime.parse(json['ddr']),
      parite: json["parite"],
      gesteNbreGrossesse: json["gesteNbreGrossesse"],
      nbreAvortement: json["nbreAvortement"],
      ageDernierEnfant: json["ageDernierEnfant"],
      statut: json["statut"],
      signature: json["signature"],
      institut: json["institut"],
      createdAntecedant: DateTime.parse(json['createdAntecedant']),
    );
  }

  AntecedantFicheModel.fromDatabase(RecordSnapshot<int, Map<String, dynamic>> snapshot)
      : id = snapshot.key,
        identifiant = snapshot.value['identifiant'] as int,
        religion = snapshot.value['religion'] as String,
        etatCivil = snapshot.value['etatCivil'] as String,
        passion = snapshot.value['passion'] as String,
        tumbakuYazolo = snapshot.value['tumbakuYazolo'] as bool,
        allergies = snapshot.value['allergies'] as bool,
        allergiesText = snapshot.value['allergiesText'] as String,
        ista = snapshot.value['ista'] as bool,
        diabete = snapshot.value['diabete'] as bool,
        tabac = snapshot.value['tabac'] as bool,
        alcool = snapshot.value['alcool'] as bool,
        produitsApperitifs = snapshot.value['produitsApperitifs'] as bool,
        produitsApperitifsText = snapshot.value['produitsApperitifsText'] as String,
        consultationNeuroPhsychiatrique =
            snapshot.value['consultationNeuroPhsychiatrique'] as bool,
        consultationNeuroPhsychiatriqueText =
            snapshot.value['consultationNeuroPhsychiatriqueText'] as String,
        ddr = DateTime.parse(snapshot.value['ddr'] as String),
        parite = snapshot.value['parite'] as String,
        gesteNbreGrossesse = snapshot.value['gesteNbreGrossesse'] as String,
        nbreAvortement = snapshot.value['nbreAvortement'] as String,
        ageDernierEnfant = snapshot.value['ageDernierEnfant'] as String,
        statut = snapshot.value['statut'] as String,
        signature = snapshot.value['signature'] as String,
        institut = snapshot.value['institut'] as String,
        createdAntecedant = DateTime.parse(snapshot.value['createdAntecedant'] as String);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'identifiant': identifiant,
      'religion': religion,
      'etatCivil': etatCivil,
      'passion': passion,
      'tumbakuYazolo': tumbakuYazolo,
      'allergies': allergies,
      'allergiesText': allergiesText,
      'ista': ista,
      'diabete': diabete,
      'tabac': tabac,
      'alcool': alcool,
      'produitsApperitifs': produitsApperitifs,
      'produitsApperitifsText': produitsApperitifsText,
      'consultationNeuroPhsychiatrique': consultationNeuroPhsychiatrique,
      'consultationNeuroPhsychiatriqueText':
          consultationNeuroPhsychiatriqueText,
      'ddr': ddr.toIso8601String(),
      'parite': parite,
      'gesteNbreGrossesse': gesteNbreGrossesse,
      'nbreAvortement': nbreAvortement,
      'ageDernierEnfant': ageDernierEnfant,
      'statut': statut,
      'signature': signature,
      'institut': institut,
      'created': createdAntecedant.toIso8601String()
    };
  }
}