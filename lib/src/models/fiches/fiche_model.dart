import 'package:sembast/sembast.dart';

class FicheModel {
  // Identité
  final int? id;
  final String nom;
  final String postNom;
  final String preNom;
  final String sexe;
  final String age;
  final String taille;
  final String poids;
  final String tensionArterielle;
  final String email;
  final String telephone;
  final String nomPere;
  final String nomMere;
  final String provinceOrigine;
  final String adresse;

  // Personnels
  final String religion;
  final String etatCivil;
  final String passion;
  final bool tumbakuYazolo;

  // Medico chirurgicaux
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

  // Gyneco obstetrique
  final DateTime ddr;
  final String parite;
  final String gesteNbreGrossesse;
  final String nbreAvortement;
  final String ageDernierEnfant;

  // Examen ou bilan realiser
  final String groupSanguin;
  final bool resus;
  final String hbs;
  final String electrophoreuseHb;

  // Examen ou bilan realiser
  final String conclusion;

  final String statut; // En attente ou ok
  final String signature;
  final String institut;
  final DateTime created;

  FicheModel({
    this.id,
    required this.nom,
    required this.postNom,
    required this.preNom,
    required this.sexe,
    required this.age,
    required this.taille,
    required this.poids,
    required this.tensionArterielle,
    required this.email,
    required this.telephone,
    required this.nomPere,
    required this.nomMere,
    required this.provinceOrigine,
    required this.adresse,
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
    required this.groupSanguin,
    required this.resus,
    required this.hbs,
    required this.electrophoreuseHb,
    required this.conclusion,
    required this.statut,
    required this.signature,
    required this.institut,
    required this.created,
  });

  factory FicheModel.fromJson(Map<String, dynamic> json) {
    return FicheModel(
      id: json['id'],
      nom: json['nom'],
      postNom: json['postNom'],
      preNom: json["preNom"],
      sexe: json["sexe"],
      age: json["age"],
      taille: json["taille"],
      poids: json["poids"],
      tensionArterielle: json["tensionArterielle"],
      email: json["email"],
      telephone: json["telephone"],
      nomPere: json["nomPere"],
      nomMere: json["nomMere"],
      provinceOrigine: json["provinceOrigine"],
      adresse: json["adresse"],
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
      groupSanguin: json["groupSanguin"],
      resus: json["resus"],
      hbs: json["hbs"],
      electrophoreuseHb: json["electrophoreuseHb"],
      conclusion: json["conclusion"],
      statut: json["statut"],
      signature: json["signature"],
      institut: json["institut"],
      created: DateTime.parse(json['created']),
    );
  }

  FicheModel.fromDatabase(RecordSnapshot<int, Map<String, dynamic>> snapshot)
      : id = snapshot.key,
        nom = snapshot.value['nom'] as String,
        postNom = snapshot.value['postNom'] as String,
        preNom = snapshot.value['preNom'] as String,
        sexe = snapshot.value['sexe'] as String,
        age = snapshot.value['age'] as String,
        taille = snapshot.value['taille'] as String,
        poids = snapshot.value['poids'] as String,
        tensionArterielle = snapshot.value['tensionArterielle'] as String,
        email = snapshot.value['email'] as String,
        telephone = snapshot.value['telephone'] as String,
        nomPere = snapshot.value['nomPere'] as String,
        nomMere = snapshot.value['nomMere'] as String,
        provinceOrigine = snapshot.value['provinceOrigine'] as String,
        adresse = snapshot.value['adresse'] as String,
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
        groupSanguin = snapshot.value['groupSanguin'] as String,
        resus = snapshot.value['resus'] as bool,
        hbs = snapshot.value['hbs'] as String,
        electrophoreuseHb = snapshot.value['electrophoreuseHb'] as String,
        conclusion = snapshot.value['conclusion'] as String,
        statut = snapshot.value['statut'] as String,
        signature = snapshot.value['signature'] as String,
        institut = snapshot.value['institut'] as String,
        created = DateTime.parse(snapshot.value['created'] as String);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'postNom': postNom,
      'preNom': preNom,
      "age": age,
      'taille': taille,
      'poids': poids,
      'tensionArterielle': tensionArterielle,
      'email': email,
      'telephone': telephone,
      'nomPere': nomPere,
      'nomMere': nomMere,
      'provinceOrigine': provinceOrigine,
      'adresse': adresse,
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
      'groupSanguin': groupSanguin,
      'resus': resus,
      'hbs': hbs,
      'electrophoreuseHb': electrophoreuseHb,
      'conclusion': conclusion,
      'statut': statut,
      'signature': signature,
      'institut': institut,
      'created': created.toIso8601String()
    };
  }
}
