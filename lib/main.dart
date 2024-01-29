import 'package:flutter/material.dart';
import 'package:gemini_flutter/src/pages/chat/chat.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Gemini',
      debugShowCheckedModeBanner: false,
      home: const ChatPage(),
    );
  }
}
