import 'package:flutter_avance/UI/login.dart';
import 'package:flutter_avance/data/model/user.dart';

abstract class ILoginUserCases {
  Future<User?> checkUserCredentials(String username, String password);
}

abstract class LoginRouter {
  void displayLogin(User user);
}

class LoginViewModel extends ILoginViewModel {
  final LoginRouter _router;
  final ILoginUserCases _userCases;
  bool _isLoading = false;
  String? _errorMessage;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;

  String? _email;
  String? _password;

  LoginViewModel(this._userCases, this._router);

  @override
  bool get isLoading => _isLoading;
  @override
  String? get errorMessage => _errorMessage;
  @override
  String? get emailErrorMessage => _emailErrorMessage;
  @override
  String? get passwordErrorMessage => _passwordErrorMessage;

  @override
  void emailChanged(String newEmail) {
    _email = newEmail;
    _emailErrorMessage = null;
  }

  @override
  void passwordChanged(String newPassword) {
    _password = newPassword;
    _passwordErrorMessage = null;
  }

  bool get _minimalInputIsValid =>
      _email != null &&
      _password != null &&
      _emailErrorMessage == null &&
      _passwordErrorMessage == null;

  @override
  void loginUser() async {
    final email = _email;
    final password = _password;
    if (email != null && password != null) {
      if (email.contains("@") == false) {
        _emailErrorMessage = "Email Invalide";
        notifyListeners();
      }

      if (password.isEmpty) {
        _password = "Mot de passe invalide";
        notifyListeners();
      }

      if (_minimalInputIsValid) {
        _isLoading = true;
        notifyListeners();
        final user = await _userCases.checkUserCredentials(email, password);
        _isLoading = false;
        if (user != null) {
          _router.displayLogin(user);
        } else {
          _errorMessage = "Bienvenue Impossible de trouvé votre compte";
        }

        notifyListeners();
      }
    }
  }
}
