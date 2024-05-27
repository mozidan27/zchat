import 'package:flutter/material.dart';
import 'package:zchat/components/my_drawer.dart';
import 'package:zchat/services/auth/auth_service.dart';
import 'package:zchat/services/chat/chat_services.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat and auth services

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      drawer: const MyDrawer(),
    );
  }
}
