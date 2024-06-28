
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:untitled1/screens/login_page.dart';

void main() {
  final client = StreamChatClient(
    '6ed22fjegmsk',
    logLevel: Level.INFO,
  );

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final StreamChatClient client;

  const MyApp({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => StreamChat(
        client: client,
        child: child!,
      ),
      home: LoginPage(client: client),
    );
  }
}




