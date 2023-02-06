import 'package:get/get.dart';
import 'package:vendor/constants/chat_firestore_db.dart';
import 'package:vendor/models/chat_model.dart';

class ChatController extends GetxController {
  Rx<List<ChatModel>> chatList = Rx<List<ChatModel>>([]);

  List<ChatModel> get chat => chatList.value;

  @override
  void onReady() {
    chatList.bindStream(ChatFirestoreDb.chatStream());
  }
}
