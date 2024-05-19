import 'package:flutter/material.dart';
import 'package:zchat/pages/login_page.dart';
import 'package:zchat/pages/register_page.dart';

class LoginAndRegister extends StatefulWidget {
  const LoginAndRegister({super.key});

  @override
  State<LoginAndRegister> createState() => _LoginAndRegisterState();
}

class _LoginAndRegisterState extends State<LoginAndRegister> {
  // initially show the login page
  bool showLoginPage = true;
  // toggle between login and register page

  void togglePages() {
    setState(
      () {
        showLoginPage = !showLoginPage;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return showLoginPage
        ? LoginPage(
            onTap: togglePages,
          )
        : RegisterPage(
            onTap: togglePages,
          );
  }
}
