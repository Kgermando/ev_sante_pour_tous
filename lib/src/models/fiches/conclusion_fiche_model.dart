import 'package:sembast/sembast.dart';

class ConclusionFicheModel {
  final int? id;
  final int identifiant;
  final String conclusion;
  final String statut; // En attente ou ok
  final String signature;
  final String institut;
  final DateTime createdConsulsion;

  ConclusionFicheModel({
    this.id,
    required this.identifiant,
    required this.conclusion,
    required this.statut,
    required this.signature,
    required this.institut,
    required this.createdConsulsion,
  });

  factory ConclusionFicheModel.fromJson(Map<String, dynamic> json) {
    return ConclusionFicheModel(
      id: json['id'],
      identifiant: json["identifiant"],
      conclusion: json["conclusion"],
      statut: json["statut"],
      signature: json["signature"],
      institut: json["institut"],
      createdConsulsion: DateTime.parse(json['createdConsulsion']),
    );
  }

  ConclusionFicheModel.fromDatabase(RecordSnapshot<int, Map<String, dynamic>> snapshot)
    : id = snapshot.key,
      identifiant = snapshot.value['identifiant'] as int,
      conclusion = snapshot.value['conclusion'] as String,
      statut = snapshot.value['statut'] as String,
      signature = snapshot.value['signature'] as String,
      institut = snapshot.value['institut'] as String,
      createdConsulsion = DateTime.parse(snapshot.value['createdConsulsion'] as String);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'identifiant': identifiant,
      'conclusion': conclusion,
      'statut': statut,
      'signature': signature,
      'institut': institut,
      'createdConsulsion': createdConsulsion.toIso8601String()
    };
  }
}