import 'dart:developer';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/services/chat_services.dart';
import '../../utils/states/chat_state.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  late final ChatState chatState;
  final ChatUser myself = ChatUser(id: '1', firstName: 'Barba');
  final ChatUser bot = ChatUser(id: '2', firstName: 'Gemini');

  @override
  void initState() {
    super.initState();
    var chatService = ChatService(
      apiUrl:
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyCuuBacvNqqATJ7NPYYG7NmW89ZGKLVd5c',
      bot: bot,
    );
    chatState = ChatState(
      chatService: chatService,
      bot: bot,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      maintainBottomViewPadding: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Flutter Gemini',
            style: GoogleFonts.asap(
              color: Colors.black,
              fontSize: 26,
              fontStyle: FontStyle.italic,
              letterSpacing: .6,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        drawer: Drawer(
          surfaceTintColor: Colors.black,
          child: ListView(
            children: [
              ListTile(
                leading: CircleAvatar(),
                title: Text(
                  'Barba Tech',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    letterSpacing: .6,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                subtitle: Text(
                  'email@email.com',
                  style: GoogleFonts.roboto(),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  'Home',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 18,
                    letterSpacing: .6,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        body: DashChat(
          inputOptions: InputOptions(
            alwaysShowSend: true,
            sendOnEnter: true,
            inputDecoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10.0),
              border: const OutlineInputBorder(
                gapPadding: 8,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.camera_alt_rounded),
                color: Colors.grey[800],
                onPressed: () {
                  // Send Image - Premium feature
                },
              ),
              fillColor: Colors.grey[800],
              hintText: 'Write a message...',
            ),
          ),
          messageListOptions: const MessageListOptions(),
          messageOptions: const MessageOptions(),
          currentUser: myself,
          onSend: (ChatMessage message) {
            chatState.sendMessage(message.text, myself).then((_) {
              setState(() {});
            });
          },
          messages: chatState.messages,
          typingUsers: chatState.typing,
        ),
      ),
    );
  }
}
