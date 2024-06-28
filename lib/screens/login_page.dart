import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'list_user_screen.dart';



class LoginPage extends StatefulWidget {
  final StreamChatClient client;

  const LoginPage({Key? key, required this.client}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _selectedUser;
  final Map<String, String> _userTokens = {
    'nouran': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibm91cmFuIn0.tH299TP8Wmyv5keOMVkFTNdW3Se2h3D4yc8fNnPh1h4',
    'montaser': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibW9udGFzZXIifQ.vmK-OgMcrJhIefF4o4yqNGdiOLYSDVnk-P3gipG6kIo'
  };

  void _login() async {
    if (_selectedUser != null) {
      final token = _userTokens[_selectedUser!];
      try {
        await widget.client.connectUser(
          User(id: _selectedUser!),
          token!,
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const UserListPage(),
          ),
        );
      } catch (e) {
        print('Error connecting user: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('nouran'),
              leading: Radio<String>(
                value: 'nouran',
                groupValue: _selectedUser,
                onChanged: (value) {
                  setState(() {
                    _selectedUser = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('montaser'),
              leading: Radio<String>(
                value: 'montaser',
                groupValue: _selectedUser,
                onChanged: (value) {
                  setState(() {
                    _selectedUser = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}