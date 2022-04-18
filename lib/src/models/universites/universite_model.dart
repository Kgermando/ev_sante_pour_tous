import 'package:sembast/sembast.dart';

class UniversiteModel {
  final int? id;
  final String name;
  final String sousNom;
  final String boitePostale;
  final String pays;
  final String province;
  final String adresse;
  final String email;
  final String telephone;
  final String siteweb;
  final DateTime created;

  UniversiteModel(
      {this.id,
      required this.name,
      required this.sousNom,
      required this.boitePostale,
      required this.pays,
      required this.province,
      required this.adresse,
      required this.email,
      required this.telephone,
      required this.siteweb,
    required this.created,
  });

   factory UniversiteModel.fromJson(Map<String, dynamic> json) {
    return UniversiteModel(
      id: json['id'],
      name: json['name'],
      sousNom: json['sousNom'],
      boitePostale: json['boitePostale'],
      pays: json["pays"],
      province: json["province"],
      adresse: json["adresse"],
      email: json["email"],
      telephone: json["telephone"],
      siteweb: json["siteweb"],
      created: DateTime.parse(json['created']),
    );
  }

  UniversiteModel.fromDatabase(
      RecordSnapshot<int, Map<String, dynamic>> snapshot)
    : id = snapshot.key,
      name = snapshot.value['name'] as String,
      sousNom = snapshot.value['sousNom'] as String,
      boitePostale = snapshot.value['boitePostale'] as String,
      pays = snapshot.value['pays'] as String,
      province = snapshot.value['province'] as String,
      adresse = snapshot.value['adresse'] as String,
      email = snapshot.value['email'] as String,
      telephone = snapshot.value['telephone'] as String,
      siteweb = snapshot.value['siteweb'] as String,
        created = DateTime.parse(snapshot.value['created'] as String);


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sousNom': sousNom,
      'boitePostale': boitePostale,
      'pays': pays,
      "province": province,
      'adresse': adresse,
      'email': email,
      'telephone': telephone,
      'siteweb': siteweb,
      'created': created.toIso8601String()
    };
  }
}
