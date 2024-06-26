import 'package:flutter/material.dart';
import 'package:zchat/services/auth/auth_service.dart';
import 'package:zchat/components/my_button.dart';
import 'package:zchat/components/my_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key, required this.onTap});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pWController = TextEditingController();
  final void Function()? onTap;

// login method

  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    // try login
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _pWController.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo or image
            Icon(
              Icons.chat,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(
              height: 20,
            ),

            // welcome text
            Text(
              'Welcome back you\'ve been missed!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // email box
            MyTextField(
                controller: _emailController,
                hintText: 'Email',
                obscureText: false),
            const SizedBox(
              height: 10,
            ),

            // PW box
            MyTextField(
                controller: _pWController,
                hintText: 'Password',
                obscureText: true),
            const SizedBox(
              height: 30,
            ),

            // login button
            MyButton(
              text: 'Login',
              onTap: () => login(context),
            ),

            const SizedBox(
              height: 30,
            ),

            // register now

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a memeber? ',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'Register now',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
