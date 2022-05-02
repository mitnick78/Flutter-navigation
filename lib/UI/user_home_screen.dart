import 'package:flutter/material.dart';

abstract class IUserHomeViewModel {
  String get email;

  void logout();
  void UserTouchedSettingsButton();
}

class UserHomeScreen extends StatelessWidget {
  final IUserHomeViewModel vm;
  const UserHomeScreen(this.vm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Column(
        children: [
          Text(
            "Vous avez comme email ${vm.email}",
            style: Theme.of(context).textTheme.headline2,
          ),
          ElevatedButton.icon(
              onPressed: vm.UserTouchedSettingsButton,
              icon: const Icon(Icons.settings),
              label: const Text("Setting")),
          OutlinedButton(onPressed: vm.logout, child: const Text("Logout"))
        ],
      ),
    );
  }
}
