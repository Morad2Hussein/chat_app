import 'package:chatapp/constant.dart';
import 'package:chatapp/model/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {

  final Color color;

   ChatBubble({
    Key? key,
    required this.message,
    this.color = kiPrimaryColor,
     // Default color
  }) : super(key: key);
final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(

        padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),

        decoration: BoxDecoration(
          color: color, // Use the provided color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Text(
          message.message ,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: "Pacifico",
          ),
        ),
      ),
    );
  }
}





class ChatBubbleFor extends StatelessWidget {

  final Color color;

  ChatBubbleFor({
    Key? key,
    required this.message,
    this.color = kPrimaryColor,
     // Default color
  }) : super(key: key);
final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(

        padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),

        decoration: BoxDecoration(
          color: color, // Use the provided color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        child: Text(
          message.message ,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: "Pacifico",
          ),
        ),
      ),
    );
  }
}
