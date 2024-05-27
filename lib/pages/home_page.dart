import 'package:flutter/material.dart';
import 'package:zchat/components/my_drawer.dart';
import 'package:zchat/components/user_tile.dart';
import 'package:zchat/pages/chat_page.dart';
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
      body: _buildUserList(),
    );
  }
  // build list of users except for the current logged in user

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text("Error");
        }
        // loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }
        // return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  // build individual list tile for user

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all users except current user
    return UserTile(
      text: userData["email"],
      onTap: () {
        // tapped on a user to navigate the chat page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail: userData["email"],
            ),
          ),
        );
      },
    );
  }
}
