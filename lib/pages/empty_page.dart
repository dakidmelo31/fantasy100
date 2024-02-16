import 'package:flutter/material.dart';

class EmptyPage extends StatefulWidget {
  EmptyPage(this.payload, {super.key});
  static const routeName = "/empty";
  String? payload;

  @override
  State<EmptyPage> createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Empty Page"),
    );
  }
}
