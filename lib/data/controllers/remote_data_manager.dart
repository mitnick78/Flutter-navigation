import 'package:flutter_avance/data/model/user.dart';

class RemoteDataManager {
  Future<User?> loadCurrentUser() {
    return Future.value(const User(23, "toto@gmail.com"));
  }
}
