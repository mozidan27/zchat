import 'package:flutter/material.dart';
import 'package:zchat/auth/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // logout method

  void logout() {
    // get auth service
    final auth = AuthService();

    // sign out
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
