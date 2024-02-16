import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hospital/utils/globals.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditDetail extends StatefulWidget {
  const EditDetail({Key? key, required this.name, this.initial = ''})
      : super(key: key);
  final String name;
  final String initial;
  @override
  State<EditDetail> createState() => _EditDetailState();
}

class _EditDetailState extends State<EditDetail> {
  late final TextEditingController _editingController;

  bool changedName = false;
  DateTime futureTime = DateTime.now();
  update() async {
    DateTime now = await NTP.now();

    final _pref = await SharedPreferences.getInstance();

    debugPrint("run here");
    if (_pref.containsKey("name") && widget.name.toLowerCase() == "name") {
      debugPrint("go here to find information");
      DateTime nameTime =
          DateTime.fromMillisecondsSinceEpoch(_pref.getInt("name") ?? 0);

      futureTime = nameTime;
      debugPrint("Get Time: ${nameTime.compareTo(now)}");
      if (nameTime.compareTo(now) > 0) {
        changedName = true;
        Globals.toast("Wait for ${futureTime.day} days to change again");
      } else {
        await _pref.remove("name");
      }
    } else {
      debugPrint("not here");
    }
    setState(() {});
  }

  @override
  void initState() {
    label = widget.name;
    _editingController = TextEditingController(text: widget.initial);
    update();
    super.initState();
  }

  late String label;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 4,
        sigmaY: 4,
      ),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Globals.primaryColor,
          actions: [
            if (_editingController.text.trim() != widget.initial)
              AnimatedSwitcher(
                duration: Globals.mainDuration,
                switchInCurve: Curves.fastLinearToSlowEaseIn,
                transitionBuilder: (child, animation) => SizeTransition(
                    sizeFactor: animation,
                    axisAlignment: 60,
                    axis: Axis.horizontal,
                    child: child),
                child: TextButton(
                    onPressed: () async {
                      Globals.vibrate();
                      if (label.toLowerCase() == "phone") {
                        Globals.toast("You cannot change $label now");
                      }
                    },
                    child: const Text("Save",
                        style: TextStyle(
                            color: Color(0xff00aa00),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500))),
              ),
          ],
          elevation: 0,
          centerTitle: false,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title:
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        backgroundColor: Colors.white.withOpacity(.4),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          children: [
            Text(label),
            TextField(
              onChanged: (value) => setState(() {}),
              controller: _editingController,
              autofocus: true && !changedName,
              keyboardType: label.toLowerCase() == "phone"
                  ? TextInputType.phone
                  : TextInputType.text,
              decoration: InputDecoration(
                enabled: !changedName,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 12.0),
                border: InputBorder.none,
                hintText: "Name",
                filled: true,
                fillColor: const Color(0xFFF9F9F9),
              ),
            )
          ],
        ),
      ),
    );
  }
}
