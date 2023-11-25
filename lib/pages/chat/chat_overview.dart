import 'package:flutter/material.dart';
import 'package:hospital/utils/globals.dart';

class ChatOverview extends StatefulWidget {
  const ChatOverview({super.key});

  static const routeName = "/overview";

  @override
  State<ChatOverview> createState() => _ChatOverviewState();
}

class _ChatOverviewState extends State<ChatOverview> {
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar.large(
            automaticallyImplyLeading: false,
            floating: true,
            pinned: true,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.circle_notifications_rounded))
            ],
            title: Text("Chat"),
          )
        ],
      ),
    );
  }
}
