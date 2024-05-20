import 'package:flutter/material.dart';
import 'package:zchat/auth/auth_service.dart';
import 'package:zchat/components/my_button.dart';
import 'package:zchat/components/my_text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key, required this.onTap});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pWController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final void Function()? onTap;

// sign up method

  void signup(BuildContext context) {
    // get auth service

    final auth = AuthService();

    // passwords match -> create user
    if (_pWController.text == _confirmPwController.text) {
      try {
        auth.signUpWithEmailPassword(_emailController.text, _pWController.text);
        // not match pirnt the exception
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords don't match!"),
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
              'Let\'s create an account for you',
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
              height: 10,
            ),
            // confirm pw
            MyTextField(
                controller: _confirmPwController,
                hintText: 'Confirm Password',
                obscureText: true),

            const SizedBox(
              height: 30,
            ),

            // login button

            MyButton(
              text: 'Sign up',
              onTap: () => signup(context),
            ),

            const SizedBox(
              height: 30,
            ),

            // register now

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'Login now',
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
