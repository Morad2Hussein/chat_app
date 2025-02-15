import 'package:chatapp/constant.dart';

class MessageModel{
  final String message;
  final String id;

  MessageModel(this.message, this.id);

factory MessageModel.fromJson( jsonData) {
    return MessageModel(
        /*jsonData[kMessage],
        jsonData['id']);*/
        jsonData[kMessage]?.toString() ?? '',  // Ensure message is a valid string
        jsonData['id']?.toString() ?? '',
    );    // Ensure id is a valid string
  }


}