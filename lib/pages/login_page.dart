import 'package:flutter/material.dart';
import 'package:zchat/components/my_button.dart';
import 'package:zchat/components/my_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key, required this.onTap});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pWController = TextEditingController();
  final void Function()? onTap;

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
            const MyButton(text: 'Login'),

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
