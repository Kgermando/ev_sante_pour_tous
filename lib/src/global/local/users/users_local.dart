import 'dart:async';

import 'package:sante_pour_tous/src/global/local/sembast_local.dart';
import 'package:sante_pour_tous/src/models/users/user_model.dart';
import 'package:sembast/sembast.dart';

class UserLocal {
  static const String storeName = 'users';

  final _store = intMapStoreFactory.store(storeName);
  Future<Database> get _db async => await SembastLocal.instance.database;

  insertData(UserModel userModel) async {
    await _store.add(await _db, userModel.toJson());
  }

  updateData(UserModel userModel) async {
    final finder = Finder(filter: Filter.byKey(userModel.id));
    await _store.update(await _db, userModel.toJson(), finder: finder);
  }

  Future<Stream<List<UserModel>>> getAllDataStream() async {
    // debugPrint("Geting Data Stream");
    var streamTransformer = StreamTransformer<
        List<RecordSnapshot<int, Map<String, dynamic>>>,
        List<UserModel>>.fromHandlers(
      handleData: _streamTransformerHandlerData,
    );

    return _store.query().onSnapshots(await _db).transform(streamTransformer);
  }

  Future<List<UserModel>> getAllData() async {
    final snapshot = await _store.find(await _db);
    return snapshot.map((e) => UserModel.fromDatabase(e)).toList();
  }

  Future<UserModel> getOneData(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    final snapshot = await _store.find(await _db, finder: finder);
    return snapshot.map((e) => UserModel.fromDatabase(e)).first;
  }

  _streamTransformerHandlerData(
      List<RecordSnapshot<int, Map<String, dynamic>>> snapshotList,
      EventSink<List<UserModel>> sink) {
    List<UserModel> resultSet = [];
    for (var element in snapshotList) {
      resultSet.add(UserModel.fromDatabase(element));
    }
    sink.add(resultSet);
  }

  delete(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    await _store.delete(await _db, finder: finder);
  }
}