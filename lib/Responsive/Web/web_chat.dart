import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Constants.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Services/Chat/chat_service.dart';
import 'package:lackstage/Services/Firebase/Auth.dart';
import 'package:lackstage/ui/chat_bubble.dart';

class WebChat extends StatefulWidget {
  final String receiverUserID;
  const WebChat({super.key, required this.receiverUserID});

  @override
  State<WebChat> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<WebChat> {
  int _page = 14;
  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    //only send message if textfield is not empty
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      //clear text controller after sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar,
        body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //open drawer
          Drawer(
            width: 250,
            elevation: 0,
            backgroundColor: Pallete.backgroundColor,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DrawerHeader(
                      child: Image.asset(
                    'assets/images/Logo.png',
                    height: 75,
                  )),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Pagina Inicial'),
                    onTap: () {
                      onPageChange(0);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.search),
                    title: const Text('Explorar'),
                    onTap: () {
                      onPageChange(1);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_box_outlined),
                    title: const Text('Perfil'),
                    onTap: () {
                      onPageChange(2);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('Notificações'),
                    onTap: () {
                      onPageChange(3);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.message),
                    title: const Text('Bate Papo'),
                    onTap: () {
                      onPageChange(4);
                    },
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: const Icon(Icons.logout),
                          iconColor: Pallete.redColor,
                          title: const Text('Deslogar',
                              style: TextStyle(color: Pallete.redColor)),
                          onTap: () {
                            authUser().deslogar();
                          },
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          Container(
            height: double.infinity,
            width: 0.5, // Largura da linha vertical
            color: Pallete.borderColor, // Cor da linha vertical
            margin:
                const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
          ),
          //rest of the body
          SizedBox(
              width: 600,
              height: double.infinity,
              child: _page != 14
                  ? IndexedStack(
                      index: _page, children: AssetsConstants.pagesweb)
                  : Scaffold(
                      appBar: AppBar(title: Text(widget.receiverUserID)),
                      body: Column(
                        children: [
                          //messages
                          Expanded(
                            child: _buildMessageList(),
                          ),

                          //user input
                          _buildMessageInput(),

                          const SizedBox(height: 25),
                        ],
                      ),
                    ))
        ]));
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverUserID,
          _firebaseAuth.currentUser!.displayName.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // align the messages
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.displayName)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.displayName)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            Text(data['senderName']),
            const SizedBox(height: 5),
            ChatBubble(message: data['message']),
          ],
        ),
      ),
    );
  }

  //build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          //textfield
          Expanded(
              child: TextField(
            controller: _messageController,
            decoration: const InputDecoration(hintText: 'Mensagem...'),
          )),
          //send button
          IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                size: 40,
              ))
        ],
      ),
    );
  }
}
