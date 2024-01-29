import 'package:flutter/material.dart';
import 'package:gemini_flutter/src/pages/chat/chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gemini',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurpleAccent,
          primary: Colors.purple,
        ),
        platform: TargetPlatform.iOS,
        useMaterial3: true,
      ),
      home: const ChatBot(),
    );
  }
}
