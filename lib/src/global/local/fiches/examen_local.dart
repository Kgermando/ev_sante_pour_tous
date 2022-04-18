import 'package:sante_pour_tous/src/global/local/sembast_local.dart';
import 'package:sante_pour_tous/src/models/fiches/examen_fiche_model.dart';
import 'package:sembast/sembast.dart';

class ExamenLocal {
  static const String storeName = 'fiches_examen';

  final _store = intMapStoreFactory.store(storeName);
  Future<Database> get _db async => await SembastLocal.instance.database;

  insertData(ExamentFicheModel examentFicheModel) async {
    await _store.add(await _db, examentFicheModel.toJson());
  }

  updateData(ExamentFicheModel examentFicheModel) async {
    final finder = Finder(filter: Filter.byKey(examentFicheModel.id));
    await _store.update(await _db, examentFicheModel.toJson(),
        finder: finder);
  }

  Future<List<ExamentFicheModel>> getAllData() async {
    final snapshot = await _store.find(await _db);
    return snapshot.map((e) => ExamentFicheModel.fromDatabase(e)).toList();
  }

  Future<ExamentFicheModel> getOneData(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    final snapshot = await _store.find(await _db, finder: finder);
    return snapshot.map((e) => ExamentFicheModel.fromDatabase(e)).first;
  }

  delete(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    await _store.delete(await _db, finder: finder);
  }
}