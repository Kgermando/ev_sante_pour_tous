import 'package:sante_pour_tous/src/global/local/sembast_local.dart';
import 'package:sante_pour_tous/src/models/fiches/conclusion_fiche_model.dart';
import 'package:sembast/sembast.dart';

class ConclusionLocal {
  static const String storeName = 'fiches_conclusion';

  final _store = intMapStoreFactory.store(storeName);
  Future<Database> get _db async => await SembastLocal.instance.database;

  insertData(ConclusionFicheModel conclusionFicheModel) async {
    await _store.add(await _db, conclusionFicheModel.toJson());
  }

  updateData(ConclusionFicheModel conclusionFicheModel) async {
    final finder = Finder(filter: Filter.byKey(conclusionFicheModel.id));
    await _store.update(await _db, conclusionFicheModel.toJson(),
        finder: finder);
  }

  Future<List<ConclusionFicheModel>> getAllData() async {
    final snapshot = await _store.find(await _db);
    return snapshot.map((e) => ConclusionFicheModel.fromDatabase(e)).toList();
  }

  Future<ConclusionFicheModel> getOneData(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    final snapshot = await _store.find(await _db, finder: finder);
    return snapshot.map((e) => ConclusionFicheModel.fromDatabase(e)).first;
  }

  delete(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    await _store.delete(await _db, finder: finder);
  }
}