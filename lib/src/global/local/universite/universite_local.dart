import 'dart:async';

import 'package:sante_pour_tous/src/global/local/sembast_local.dart';
import 'package:sante_pour_tous/src/models/universites/universite_model.dart';
import 'package:sembast/sembast.dart';

class UniversiteLocal {
  static const String storeName = 'universites';

  final _store = intMapStoreFactory.store(storeName);
  Future<Database> get _db async => await SembastLocal.instance.database;

  insertData(UniversiteModel universiteModel) async {
    await _store.add(await _db, universiteModel.toJson());
  }

  updateData(UniversiteModel universiteModel) async {
    final finder = Finder(filter: Filter.byKey(universiteModel.id));
    await _store.update(await _db, universiteModel.toJson(), finder: finder);
  }

  Future<Stream<List<UniversiteModel>>> getAllDataStream() async {
    // debugPrint("Geting Data Stream");
    var streamTransformer = StreamTransformer<
        List<RecordSnapshot<int, Map<String, dynamic>>>,
        List<UniversiteModel>>.fromHandlers(
      handleData: _streamTransformerHandlerData,
    );

    return _store.query().onSnapshots(await _db).transform(streamTransformer);
  }

  Future<List<UniversiteModel>> getAllData() async {
    final snapshot = await _store.find(await _db);
    return snapshot.map((e) => UniversiteModel.fromDatabase(e)).toList();
  }

  Future<UniversiteModel> getOneData(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    final snapshot = await _store.find(await _db, finder: finder);
    return snapshot.map((e) => UniversiteModel.fromDatabase(e)).first;
  }

  _streamTransformerHandlerData(
      List<RecordSnapshot<int, Map<String, dynamic>>> snapshotList,
      EventSink<List<UniversiteModel>> sink) {
    List<UniversiteModel> resultSet = [];
    for (var element in snapshotList) {
      resultSet.add(UniversiteModel.fromDatabase(element));
    }
    sink.add(resultSet);
  }

  delete(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    await _store.delete(await _db, finder: finder);
  }
}