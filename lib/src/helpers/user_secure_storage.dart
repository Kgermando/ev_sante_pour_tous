import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sante_pour_tous/src/models/users/user_model.dart';

class UserSecureStorage {
  static const _keyUser = 'userModel';
  static const _keyAuth = 'authJWT';
  static const _keyIdToken = 'idToken';
  static const _keyAccessToken = 'accessToken';
  static const _keyRefreshToken = 'refreshToken';

  // Create storage
  final storage = const FlutterSecureStorage();

  Future<UserModel> readUser() async {
    final prefs = await storage.read(key: _keyUser);
    if (prefs != null) {
      UserModel user = UserModel.fromJson(jsonDecode(prefs));
      return user;
    } else {
      final user = UserModel(
          nom: 'nom',
          prenom: 'prenom',
          matricule: 'matricule',
          role: 'role',
          isOnline: false,
          createdAt: DateTime.now(),
          passwordHash: 'passwordHash',
          adresse: '');
      return user;
    }
  }

  saveUser(value) async {
    await storage.write(key: _keyUser, value: json.encode(value));
  }

  removeUser() async {
    await storage.delete(key: _keyUser);
  }

  
}