
import 'package:sembast/sembast.dart';

class UserModel {
  late int? id;
  late String nom;
  late String prenom;
  late String matricule;
  late String role;  // Acces user de medicin et laborentin ou visteur
  late bool isOnline; // Agent connecté
  late DateTime createdAt; 
  late String passwordHash;
  late String adresse;

  UserModel({
    this.id,
    required this.nom,
    required this.prenom,
    required this.matricule,
    required this.role,
    required this.isOnline,
    required this.createdAt,
    required this.passwordHash,
    required this.adresse,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      nom: json["nom"],
      prenom: json["prenom"],
      matricule: json["matricule"],
      role: json["role"],
      isOnline: json["isOnline"],
      createdAt: DateTime.parse(json["createdAt"]),
      passwordHash: json["passwordHash"],
      adresse: json["adresse"]
    );
  }


  UserModel.fromDatabase(
      RecordSnapshot<int, Map<String, dynamic>> snapshot)
    : id = snapshot.key,
      nom = snapshot.value['nom'] as String,
      prenom = snapshot.value['prenom'] as String,
      matricule = snapshot.value['matricule'] as String,
      role = snapshot.value['role'] as String,
      isOnline = snapshot.value['isOnline'] as bool,
      createdAt = DateTime.parse(snapshot.value['createdAt'] as String),
      passwordHash = snapshot.value['passwordHash'] as String,
      adresse = snapshot.value['adresse'] as String;


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'matricule': matricule,
      'role': role,
      'isOnline': isOnline,
      'createdAt': createdAt.toIso8601String(),
      'passwordHash': passwordHash,
      'adresse': adresse
    };
  }
}
