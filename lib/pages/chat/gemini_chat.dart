import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../utils/globals.dart';

class GeminiScreen extends StatefulWidget {
  GeminiScreen(this.chat);

  final Chat chat;

  @override
  State<GeminiScreen> createState() => _GeminiScreenState();
}

class _GeminiScreenState extends State<GeminiScreen>
    with TickerProviderStateMixin {
  late final TextEditingController _msgController;
  List<GenerateContentResponse> messages = [];

  bool _loading = false;
  generate() async {
    setState(() {
      _loading = true;
    });
    const apiKey = Globals.gemini;
    // For text-only input, use the gemini-pro model
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    if (_msgController.text.trim().isNotEmpty) {
      final content = [Content.text(_msgController.text.trim())];
      final response = await model.generateContent(content);
      setState(() {
        _msgController.text = "";
      });
      messages.add(response);
      debugPrint(response.text);
    }
    setState(() {
      _loading = false;
    });

    // Globals.toast(response.text.toString());
  }

  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _msgController = TextEditingController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color(0xffdddddd),
        backgroundColor: Globals.black,
        title: Row(
          children: [
            const Icon(
              FontAwesomeIcons.robot,
              size: 40,
            ),
            if (false)
              CircleAvatar(
                backgroundImage: NetworkImage(widget.chat.profilePic),
              ),
            const SizedBox(width: 10),
            const Text("Wise Melo"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text("View contact"),
                ),
                const PopupMenuItem(
                  child: Text("Media, links, and docs"),
                ),
                const PopupMenuItem(
                  child: Text("Search"),
                ),
                const PopupMenuItem(
                  child: Text("Mute notifications"),
                ),
                const PopupMenuItem(
                  child: Text("Wallpaper"),
                ),
                const PopupMenuItem(
                  child: Text("More"),
                ),
              ];
            },
          ),
        ],
        elevation: 0,
      ),
      backgroundColor: const Color(0xff172815),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            reverse: true,
            itemBuilder: (context, index) {
              final msg = messages[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: _geminiReceivedMessage(
                    Message(isCurrentUser: false, content: ""),
                    Column(
                      children: msg.candidates
                          .map((e) => Column(
                              children: e.content.parts
                                  .map((e) => Text(e.toString()))
                                  .toList()))
                          .toList(),
                    )),
              );
            },
            itemCount: messages.length,
          )),
          if (false)
            Expanded(
              child: ListView.builder(
                itemCount: widget.chat.messages.length,
                itemBuilder: (context, index) {
                  Message message = widget.chat.messages[index];
                  return message.isCurrentUser
                      ? _buildCurrentMessage(message)
                      : _buildReceivedMessage(message);
                },
              ),
            ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildCurrentMessage(Message message) {
    final size = getSize(context);
    return SizedBox(
      width: size.width * .7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Globals.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Wrap(
              children: [
                Text(
                  message.content,
                  style: GoogleFonts.poppins(color: const Color(0xffbbbbbb)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(Message message) {
    final size = getSize(context);
    return SizedBox(
      width: size.width * .7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xff1F2F16),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Wrap(
              children: [
                Text(
                  message.content,
                  style: const TextStyle(color: Color(0xffbbbbbb)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _geminiReceivedMessage(Message message, Widget child) {
    final size = getSize(context);
    return SizedBox(
      width: size.width * .7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xffaaaaaa),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Wrap(
              children: [
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: const Color(0xff3E5622),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: GoogleFonts.poppins(color: Colors.white),
              controller: _msgController,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                hintStyle: TextStyle(color: Color(0xffdddddd)),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.attach_file, color: Colors.grey),
          ),
          if (_loading)
            CircularProgressIndicator(
              color: Globals.white,
            )
          else
            IconButton(
              icon: const Icon(FontAwesomeIcons.solidPaperPlane,
                  color: Color(0xFFeeeeee)),
              onPressed: generate,
            ),
        ],
      ),
    );
  }
}

class Chat {
  final String name;
  final String profilePic;
  final List<Message> messages;

  Chat({
    required this.name,
    required this.profilePic,
    required this.messages,
  });
}

class Message {
  final bool isCurrentUser;
  final String content;

  Message({
    required this.isCurrentUser,
    required this.content,
  });
}
