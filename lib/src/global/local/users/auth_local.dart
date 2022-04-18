import 'package:sante_pour_tous/src/global/local/sembast_local.dart';
import 'package:sante_pour_tous/src/helpers/user_secure_storage.dart';
import 'package:sante_pour_tous/src/models/users/user_model.dart';
import 'package:sembast/sembast.dart';

class AuthLocal {
  static const String storeName = 'users';

  final _store = intMapStoreFactory.store(storeName);
  Future<Database> get _db async => await SembastLocal.instance.database;

  Future<bool> login(
      String matriculeController, String passwordHashController) async {
    final finder = Finder(
        filter: Filter.and([
      Filter.equals("matricule", matriculeController),
      Filter.equals("passwordHash", passwordHashController)
    ]));
    final snapshot = await _store.find(await _db, finder: finder);
    if (snapshot.isNotEmpty) {
      final user = snapshot.map((e) => UserModel.fromDatabase(e)).first;
      await logout();
      await UserSecureStorage().saveUser(user);
      return true;
    } else {
      return false;
    }
  }

  Future<void> forgotPassword() async {}

  Future<void> resetPassword() async {}

  Future<void> logout() async {
    await UserSecureStorage().removeUser();
  }
}
