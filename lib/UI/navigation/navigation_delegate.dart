import 'package:flutter/material.dart';
import 'package:flutter_avance/UI/login.dart';
import 'package:flutter_avance/UI/login_viewModel.dart';
import 'package:flutter_avance/UI/navigation/navigation_path.dart';
import 'package:flutter_avance/UI/setting_screen.dart';
import 'package:flutter_avance/UI/user_home_screen.dart';
import 'package:flutter_avance/UI/user_home_viewmodel.dart';
import 'package:flutter_avance/data/controllers/remote_data_manager.dart';
import 'package:flutter_avance/data/model/user.dart';
import 'package:flutter_avance/data/use_cases/login_use_case.dart';

class NavigationDelegate extends RouterDelegate<NavigationPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationPath>
    implements UserHomeRouter, LoginRouter {
  final RemoteDataManager _remoteDataManager = RemoteDataManager();
  User? _currentUser;
  bool _displaySetting = false;

  @override
  Widget build(BuildContext context) {
    final List<Page<dynamic>> pagesList = [];
    final user = _currentUser;
    if (user != null) {
      final homeScreen = UserHomeScreen(UserHomeViewModel(user, this));
      pagesList.add(MaterialPage(child: homeScreen));
      if (_displaySetting) {
        pagesList.add(const MaterialPage(child: SettingScreen()));
      }
    } else {
      final login = Login(LoginViewModel(LoginUseCases(), this));
      pagesList.add(MaterialPage(child: login));
    }

    return Navigator(
      pages: pagesList,
      onPopPage: (route, result) {
        if (route.didPop(result) == false) {
          return false;
        }
        return onBackButtonTouched(result);
      },
    );
  }

  onBackButtonTouched(dynamic result) {
    if (_displaySetting) {
      _displaySetting = false;
    }
    notifyListeners();
    return true;
  }

  @override
  NavigationPath? get currentConfiguration =>
      NavigationPath(userId: _currentUser?.id);

  @override
  GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(NavigationPath configuration) async {
    final userId = configuration.userId;
    if (userId != null && _currentUser == null) {
      final currentUser = await _remoteDataManager.loadCurrentUser();
      if (currentUser != null && currentUser.id == configuration.userId) {
        _currentUser = currentUser;
      }
    }
  }

  @override
  displaySetting() {
    _displaySetting = true;
    notifyListeners();
  }

  @override
  void displayLogin(User user) {
    _currentUser = user;
    notifyListeners();
  }

  @override
  void logoutCurrentUser() {
    _currentUser = null;
    notifyListeners();
  }
}
