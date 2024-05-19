import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zchat/firebase_options.dart';
import 'package:zchat/pages/login_and_register.dart';
import 'package:zchat/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginAndRegister(),
      theme: lightMode,
    );
  }
}
