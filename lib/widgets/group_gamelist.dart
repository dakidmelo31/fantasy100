import 'package:flutter/material.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:provider/provider.dart';

import 'group_card.dart';

class GroupGamelist extends StatefulWidget {
  const GroupGamelist({super.key});

  @override
  State<GroupGamelist> createState() => _GroupGamelistState();
}

class _GroupGamelistState extends State<GroupGamelist> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context, listen: true);
    final groups = data.groups;
    return Padding(
      padding: const EdgeInsets.only(bottom: 140.0),
      child: Column(
        children: groups.map((e) => GroupCard(card: e)).toList(),
      ),
    );
  }
}
