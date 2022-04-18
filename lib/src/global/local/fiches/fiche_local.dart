import 'dart:async';

import 'package:sante_pour_tous/src/global/local/sembast_local.dart';
import 'package:sante_pour_tous/src/models/fiches/fiche_model.dart';
import 'package:sembast/sembast.dart';

class FicheLocal {
  static const String storeName = 'fiches';

  final _store = intMapStoreFactory.store(storeName);
  Future<Database> get _db async => await SembastLocal.instance.database;

  insertData(FicheModel ficheModel) async {
    await _store.add(await _db, ficheModel.toJson());
  }

  updateData(FicheModel ficheModel) async {
    final finder = Finder(filter: Filter.byKey(ficheModel.id));
    await _store.update(await _db, ficheModel.toJson(), finder: finder);
  }

  Future<Stream<List<FicheModel>>> getAllDataStream() async {
    // debugPrint("Geting Data Stream");
    var streamTransformer = StreamTransformer<
        List<RecordSnapshot<int, Map<String, dynamic>>>,
        List<FicheModel>>.fromHandlers(
      handleData: _streamTransformerHandlerData,
    );

    return _store.query().onSnapshots(await _db).transform(streamTransformer);
  }

  Future<List<FicheModel>> getAllData() async {
    final snapshot = await _store.find(await _db);
    return snapshot.map((e) => FicheModel.fromDatabase(e)).toList();
  }

  Future<FicheModel> getOneData(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    final snapshot = await _store.find(await _db, finder: finder);
    return snapshot.map((e) => FicheModel.fromDatabase(e)).first;
  }

  _streamTransformerHandlerData(
      List<RecordSnapshot<int, Map<String, dynamic>>> snapshotList,
      EventSink<List<FicheModel>> sink) {
    List<FicheModel> resultSet = [];
    for (var element in snapshotList) {
      resultSet.add(FicheModel.fromDatabase(element));
    }
    sink.add(resultSet);
  }

  delete(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    await _store.delete(await _db, finder: finder);
  }
}
