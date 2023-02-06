import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  late String chatRoomId;
  late String vendorId;
  late String userId;
  late Timestamp date;
  late String conversation;
  String? chatId;

  ChatModel({
    required this.chatRoomId,
    required this.vendorId,
    required this.userId,
    required this.date,
    required this.conversation,
  });

  ChatModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    chatId = documentSnapshot.id;
    chatRoomId = documentSnapshot['chatRoomId'];
    vendorId = documentSnapshot['vendorId'];
    userId = documentSnapshot['userId'];
    date = documentSnapshot['date'];
    conversation = documentSnapshot['conversation'];
  }
}
