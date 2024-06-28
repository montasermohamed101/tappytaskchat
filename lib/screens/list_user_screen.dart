import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:untitled1/screens/chat_screen.dart';


class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late final _userListController = StreamUserListController(
    client: StreamChat.of(context).client,
    filter: Filter.notEqual('id', StreamChat.of(context).currentUser!.id),
  );

  @override
  void dispose() {
    _userListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Chats',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20),),
      ),
      body: StreamUserListView(
        controller: _userListController,
        itemBuilder: (context, users, index, defaultUserTile) {
          final user = users[index];
          return ListTile(
            leading: StreamUserAvatar(user: user),
            title: Text(user.name),
            onTap: () => _startChatWithUser(user),
          );
        },
      ),
    );
  }

  void _startChatWithUser(User user) async {
    final client = StreamChat.of(context).client;
    final channel = client.channel('messaging', extraData: {
      'members': [client.state.currentUser!.id, user.id],
    });
    await channel.watch();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return StreamChannel(
            channel: channel,
            child: const ChannelPage(),
          );
        },
      ),
    );
  }
}
