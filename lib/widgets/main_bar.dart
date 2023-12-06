import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainBar extends StatelessWidget {
  const MainBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Welcome Back"),
            Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.notifications)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.settings_rounded)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
