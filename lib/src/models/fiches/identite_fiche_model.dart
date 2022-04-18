import 'package:sembast/sembast.dart';

class IdentiteFicheModel {
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
  final String statut; // En attente ou ok
  final String signature;
  final String institut;
  final DateTime created;

  IdentiteFicheModel({
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
    required this.statut,
    required this.signature,
    required this.institut,
    required this.created,
  });

  factory IdentiteFicheModel.fromJson(Map<String, dynamic> json) {
    return IdentiteFicheModel(
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
      statut: json["statut"],
      signature: json["signature"],
      institut: json["institut"],
      created: DateTime.parse(json['created']),
    );
  }

  IdentiteFicheModel.fromDatabase(RecordSnapshot<int, Map<String, dynamic>> snapshot)
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
      "sexe": sexe,
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
      'statut': statut,
      'signature': signature,
      'institut': institut,
      'created': created.toIso8601String()
    };
  }

}
