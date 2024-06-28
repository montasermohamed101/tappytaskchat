import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelPage extends StatelessWidget {
  const ChannelPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StreamChannelHeader(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: const Column(
        children: [
          Expanded(
            child: StreamMessageListView(),
          ),
          StreamMessageInput(),
        ],
      ),
    );
  }
}


