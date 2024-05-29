import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/theme/theme_provider.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key, required this.isCurrentUser, required this.message});
  final bool isCurrentUser;
  final String message;

  @override
  Widget build(BuildContext context) {
    // lisght vs dark mode for bubble colors
    bool isDartMode =
        Provider.of<ThemeProvider>(context, listen: false).isDartMode;
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isCurrentUser
            ? (isDartMode ? Colors.green.shade600 : Colors.green.shade500)
            : (isDartMode ? Colors.grey.shade800 : Colors.grey.shade200),
      ),
      child: Text(
        message,
        style: TextStyle(
            color: isCurrentUser
                ? Colors.white
                : (isDartMode ? Colors.white : Colors.black)),
      ),
    );
  }
}
