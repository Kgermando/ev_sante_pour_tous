// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../models/users/user_model.dart';

// class UserPreferences extends ChangeNotifier {
//   static const _keyUser = 'userModel';
//   static const _keyAuth = 'authJWT';
//   static const _keyIdToken = 'idToken';
//   static const _keyAccessToken = 'accessToken';
//   static const _keyRefreshToken = 'refreshToken';

//   static Future<UserModel> read() async {
//     final prefs = await SharedPreferences.getInstance();
//     final json = prefs.getString(_keyUser);
//     if (json != null) {
//       UserModel user = UserModel.fromJson(jsonDecode(json));
//       return user;
//     } else {
//       final user = UserModel(
//           nom: 'nom',
//           prenom: 'prenom',
//           matricule: 'matricule',
//           role: 'role',
//           isOnline: false,
//           createdAt: DateTime.now(),
//           passwordHash: 'passwordHash', adresse: '');
//       return user;
//     }
//   }

//   static save(value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyUser, json.encode(value));
//   }

//   static remove() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(_keyUser);
//   }

//   static Future<bool> getAuth() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool authJWT = prefs.getBool(_keyAuth) ?? false;
//     // print('authJWT $authJWT');
//     return authJWT;
//   }

//   static setAuth() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool(_keyAuth, true);
//   }

//   static removeAuth() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(_keyAuth);
//   }

//   // ID User
//   static Future<String?> getIdToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getString(_keyIdToken);
//     return data;
//   }
//   static saveIdToken(value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_keyIdToken, json.encode(value));
//   }
//   static removeIdToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(_keyIdToken);
//   }

//   // AccessToken
//   static Future<String?> getAccessToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getString(_keyAccessToken);
//     return data;
//   }
//   static saveAccessToken(value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_keyAccessToken, json.encode(value));
//   }
//   static removeAccessToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(_keyAccessToken);
//   }

//   // RefreshToken
//   static Future<String?> getRefreshToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getString(_keyRefreshToken);
//     return data;
//   }
//   static saveRefreshToken(value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_keyRefreshToken, json.encode(value));
//   }
//   static removeRefreshToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(_keyRefreshToken);
//   }

  
// }
