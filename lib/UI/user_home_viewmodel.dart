import 'package:flutter_avance/UI/user_home_screen.dart';
import 'package:flutter_avance/data/model/user.dart';

abstract class UserHomeRouter {
  displaySetting();
  void logoutCurrentUser();
}

class UserHomeViewModel extends IUserHomeViewModel {
  final User _user;
  final UserHomeRouter _router;

  UserHomeViewModel(this._user, this._router);

  @override
  String get email => _user.email;

  @override
  void UserTouchedSettingsButton() {
    _router.displaySetting();
  }

  @override
  void logout() {
    _router.logoutCurrentUser();
  }
}
