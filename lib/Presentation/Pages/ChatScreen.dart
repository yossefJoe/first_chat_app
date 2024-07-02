import 'package:chatapp/Presentation/Widgets/Customappbar.dart';
import 'package:chatapp/Presentation/Widgets/MessageBar.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({
    super.key,
    required this.chat,
    required this.index,
  });
  final AsyncSnapshot chat;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(context),
        body: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.indigoAccent,
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.call)),
                IconButton(onPressed: () {}, icon: Icon(Icons.video_call))
              ],
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                  )),
              title: ListTile(
                  title: Text(chat
                      .data!.docs[0]['contacts'][index]['Contact_name']
                      .toString()),
                  subtitle: Text(
                    'Last Seen on 05:15 PM',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  )),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        20, // Replace with actual number of messages
                        (index) => _buildMessageWidget(index),
                      ),
                    ),
                  ),
                ),

                BottomBar(), // Method to build BottomNavigationBar
              ],
            )));
  }
}

Widget _buildMessageWidget(int index) {
  // Replace with your actual message widget based on your data structure
  return ListTile(
    title: Text('Message $index'),
    subtitle: Text('Sent on 12:00 PM'),
    leading: CircleAvatar(
      child: Text('User'),
    ),
  );
}
