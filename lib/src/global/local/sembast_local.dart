import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
// import 'package:path/path.dart' as p;

class SembastLocal with ChangeNotifier {

  static final SembastLocal instance = SembastLocal.init();

  static Database? _database;

  SembastLocal.init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // _database = await databaseFactoryIo.openDatabase(
    //   p.join('directory', 'sante_medicale.db')
    // );

    // _database = await databaseFactoryIo.openDatabase(
    //     join('.dart_tool', 'sembast', 'example', 'sante_medicale.db'));
     _database = await _openDatabase('sante_medicale2.db');
    return _database!;
  }

  Future<Database> _openDatabase(String databaseName) async {
    final Directory appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, databaseName);

    return await databaseFactoryIo.openDatabase(dbPath);
  }
}
