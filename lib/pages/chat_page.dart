import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zchat/components/chat_bubble.dart';
import 'package:zchat/components/my_text_field.dart';
import 'package:zchat/services/auth/auth_service.dart';
import 'package:zchat/services/chat/chat_services.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key, required this.receiverEmail, required this.receiverID});
  final String receiverEmail;
  final String receiverID;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController _textController = TextEditingController();

  // chat & auth. services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // for textfield focus
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        /*
         cause a delay so that the keyboard has time to show up
         then the amount of remaining space will be calculated,
         then scroll down
        */

        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });
    // wait a bit for listview to be built . then scroll down
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  // scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

// send message
  void sendMessage() async {
    // if there is something inside the textfield
    if (_textController.text.isNotEmpty) {
      // send the message
      await _chatService.sendMessage(widget.receiverID, _textController.text);
      // clear the textfield
      _textController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(widget.receiverEmail),
      ),
      body: Column(
        children: [
          // display all messages
          Expanded(
            child: _buildMessageList(),
          ),
          // user input

          _buildUserInput()
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    String sendID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, sendID),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text("Error");
        }
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }
        // return list view

        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // align message to the right if sender is the current user otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        decoration: const BoxDecoration(),
        alignment: alignment,
        child: ChatBubble(
          message: data["message"],
          isCurrentUser: isCurrentUser,
        ));
  }

  // build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        children: [
          // textfield should take up most of the space
          Expanded(
            child: MyTextField(
                focusNode: myFocusNode,
                controller: _textController,
                hintText: "Enter your message..",
                obscureText: false),
          ),

          // send button
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: const BoxDecoration(
                color: Colors.green, shape: BoxShape.circle),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
