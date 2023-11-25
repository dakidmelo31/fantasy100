import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hospital/pages/chat/chat_overview.dart';
import 'package:hospital/utils/globals.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      Navigator.pushNamed(
        context,
        '/chat',
        arguments: message,
      );
    }
  }

  int _count = 10;
  late final AnimationController _animationController;
  late final Animation<double> _mainAnim;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3400));

    _mainAnim = CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn);
    _animationController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Scaffold(
      body: AnimatedBuilder(
        animation: _mainAnim,
        builder: (context, child) => Stack(
          children: [
            Positioned(
              child: ClipOval(
                child: Container(
                  color: Colors.black,
                ),
              ),
              height: size.height * 2.45,
              width: size.height * 2.45 * (1 - _mainAnim.value),
              top: -(size.height * 2.45) / 2,
              left: -(size.height * 2.45) / 2,
            ),
            Center(
              child: MaterialButton(
                onPressed: () =>
                    Navigator.pushNamed(context, ChatOverview.routeName),
                child: Text("How would this work"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
