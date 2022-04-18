import 'package:sembast/sembast.dart';

class ExamentFicheModel { 
  final int? id;
  final int identifiant;
  final String groupSanguin;
  final bool resus;
  final String hbs;
  final String electrophoreuseHb;
  final String statut; // En attente ou ok
  final String signature;
  final String institut;
  final DateTime createdExamen;

  ExamentFicheModel({
    this.id,
    required this.identifiant,
    required this.groupSanguin,
    required this.resus,
    required this.hbs,
    required this.electrophoreuseHb,
    required this.statut,
    required this.signature,
    required this.institut,
    required this.createdExamen,
  });

  factory ExamentFicheModel.fromJson(Map<String, dynamic> json) {
    return ExamentFicheModel(
      id: json['id'],
      identifiant: json["identifiant"],
      groupSanguin: json["groupSanguin"],
      resus: json["resus"],
      hbs: json["hbs"],
      electrophoreuseHb: json["electrophoreuseHb"],
      statut: json["statut"],
      signature: json["signature"],
      institut: json["institut"],
      createdExamen: DateTime.parse(json['createdExamen']),
    );
  }

  ExamentFicheModel.fromDatabase(RecordSnapshot<int, Map<String, dynamic>> snapshot)
      : id = snapshot.key,
        identifiant = snapshot.value['identifiant'] as int,
        groupSanguin = snapshot.value['groupSanguin'] as String,
        resus = snapshot.value['resus'] as bool,
        hbs = snapshot.value['hbs'] as String,
        electrophoreuseHb = snapshot.value['electrophoreuseHb'] as String,
        statut = snapshot.value['statut'] as String,
        signature = snapshot.value['signature'] as String,
        institut = snapshot.value['institut'] as String,
        createdExamen = DateTime.parse(snapshot.value['createdExamen'] as String);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'identifiant': identifiant,
      'groupSanguin': groupSanguin,
      'resus': resus,
      'hbs': hbs,
      'electrophoreuseHb': electrophoreuseHb,
      'statut': statut,
      'signature': signature,
      'institut': institut,
      'createdExamen': createdExamen.toIso8601String()
    };
  }
}