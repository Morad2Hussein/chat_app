import 'package:chatapp/constant.dart';
import 'package:chatapp/model/message_model.dart';
import 'package:chatapp/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  static String id = '/ChatView';
  final _controller = ScrollController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollecyions);
  TextEditingController controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt,descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: kiPrimaryColor,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    // Ensures Row takes only necessary space
                    children: [
                      Image.asset(kiImage, height: 30),
                      SizedBox(width: 8),
                      Text(
                        "ChatApp",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Pacifico",
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                          controller: _controller,
                          itemCount: messageList.length,
                          itemBuilder: (context, index) {
                            return messageList[index].id == email ? ChatBubble(
                              message: messageList[index],
                            ): ChatBubbleFor(message: messageList[index]);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: controller,
                        onSubmitted: (data) {
                          messages.add({
                            kMessage: data,
                            kCreatedAt: DateTime.now(),
                            'id' : email,
                          });
                          controller.clear();
                          _controller.animateTo(
                             0,
                              duration: Duration(seconds: 5),
                              curve: Curves.decelerate);
                        },
                        decoration: InputDecoration(
                          hintText: "Send Your Message",
                          suffixIcon: Icon(
                            (Icons.send),
                            color: kiPrimaryColor,
                          ),
                          hintStyle: const TextStyle(
                            fontSize: 20.0,
                            color: kiPrimaryColor,
                            fontFamily: 'pacifico',
                          ),
                          labelStyle: const TextStyle(
                            fontSize: 20.0,
                            color: kiPrimaryColor,
                            fontFamily: 'pacifico',
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: kiPrimaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: kiPrimaryColor,
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: kiPrimaryColor,
                              )),
                        ),
                      ),
                    ),
                  ],
                ));
          } else {
            return Center(child: Text("Loading"));
          }
        });
  }
}
