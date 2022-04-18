import 'dart:async';

import 'package:sante_pour_tous/src/global/local/sembast_local.dart';
import 'package:sante_pour_tous/src/models/fiches/antecedant_fiche_model.dart';
import 'package:sembast/sembast.dart';

class AntecedantLocal {
  static const String storeName = 'fiches_antecedant';

   final _store = intMapStoreFactory.store(storeName);
  Future<Database> get _db async => await SembastLocal.instance.database;

  insertData(AntecedantFicheModel antecedantFicheModel) async {
    await _store.add(await _db, antecedantFicheModel.toJson());
  }

  updateData(AntecedantFicheModel antecedantFicheModel) async {
    final finder = Finder(filter: Filter.byKey(antecedantFicheModel.id));
    await _store.update(await _db, antecedantFicheModel.toJson(), finder: finder);
  }

  Future<List<AntecedantFicheModel>> getAllData() async {
    final snapshot = await _store.find(await _db);
    return snapshot.map((e) => AntecedantFicheModel.fromDatabase(e)).toList();
  }

  Future<AntecedantFicheModel> getOneData(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    final snapshot = await _store.find(await _db, finder: finder);
    return snapshot.map((e) => AntecedantFicheModel.fromDatabase(e)).first;
  }

  delete(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    await _store.delete(await _db, finder: finder);
  }
}