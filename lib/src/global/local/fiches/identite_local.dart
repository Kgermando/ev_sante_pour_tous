import 'package:sante_pour_tous/src/global/local/sembast_local.dart';
import 'package:sante_pour_tous/src/models/fiches/identite_fiche_model.dart';
import 'package:sembast/sembast.dart';

class IdentiteLocal {
  static const String storeName = 'fiches_identite';

  final _store = intMapStoreFactory.store(storeName);
  Future<Database> get _db async => await SembastLocal.instance.database;

  insertData(IdentiteFicheModel identiteFicheModel) async {
    await _store.add(await _db, identiteFicheModel.toJson());
  }

  updateData(IdentiteFicheModel identiteFicheModel) async {
    final finder = Finder(filter: Filter.byKey(identiteFicheModel.id));
    await _store.update(await _db, identiteFicheModel.toJson(),
        finder: finder);
  }

  Future<List<IdentiteFicheModel>> getAllData() async {
    final snapshot = await _store.find(await _db);
    return snapshot.map((e) => IdentiteFicheModel.fromDatabase(e)).toList();
  }

  Future<IdentiteFicheModel> getOneData(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    final snapshot = await _store.find(await _db, finder: finder);
    return snapshot.map((e) => IdentiteFicheModel.fromDatabase(e)).first;
  }

  delete(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    await _store.delete(await _db, finder: finder);
  }
}