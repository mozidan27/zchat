import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.text, required this.onTap});

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.secondary),
        child: Row(
          children: [const Icon(Icons.person), Text(text)],
        ),
      ),
    );
  }
}
