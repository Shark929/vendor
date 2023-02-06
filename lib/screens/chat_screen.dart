import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/constants/chat_firestore_db.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/constants/order_firestore_db.dart';
import 'package:vendor/constants/user_refund_firestore.dart';
import 'package:vendor/controllers/chat_controller.dart';
import 'package:vendor/controllers/user_refund_controller.dart';
import 'package:vendor/models/chat_model.dart';
import 'package:vendor/models/order_model.dart';
import 'package:vendor/screens/home_screen.dart';

class ChatScreen extends StatefulWidget {
  final OrderModel orderModel;
  final String vendorId, customerId, chatRoomId;
  const ChatScreen(
      {super.key,
      required this.vendorId,
      required this.customerId,
      required this.chatRoomId,
      required this.orderModel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  List chatId = [];
  @override
  Widget build(BuildContext context) {
    print(widget.customerId);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              String customerWalletAmount = "";

              showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        child: Container(
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Reasons for reject",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GetX<UserRefundController>(
                                  init: Get.put(UserRefundController()),
                                  builder: (UserRefundController urController) {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            urController.walletBalance.length,
                                        itemBuilder: (context, index) {
                                          final uModel0 =
                                              urController.walletBalance[index];
                                          if (uModel0.userId ==
                                              widget.customerId) {
                                            customerWalletAmount =
                                                uModel0.balance;
                                          }
                                          return const SizedBox();
                                        });
                                  }),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: reasons.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        //clear chat room
                                        if (chatId.isNotEmpty) {
                                          for (var e in chatId) {
                                            ChatFirestoreDb.deleteChat(e);
                                          }
                                        }

                                        //refund money
                                        print(customerWalletAmount);
                                        double totalPriceToRefund =
                                            double.parse(widget
                                                    .orderModel.quantity
                                                    .toString()) *
                                                double.parse(widget
                                                    .orderModel.foodPrice
                                                    .toString());
                                        double refundAmount =
                                            totalPriceToRefund +
                                                double.parse(
                                                    customerWalletAmount);
                                        UserRefundFirestoreDb.refundAmount(
                                            refundAmount.toStringAsFixed(2),
                                            widget.customerId);
                                        //set order code to 6
                                        OrderFirestoreDb.updateCode(
                                            "6", widget.orderModel.orderId);
                                        Get.to(() => const HomeScreen());
                                      },
                                      title: Text(reasons[index]),
                                    );
                                  })
                            ],
                          ),
                        ),
                      ));
            },
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(
              16,
            ),
            margin: const EdgeInsets.only(bottom: 40),
            height: MediaQuery.of(context).size.height - 130,
            child: GetX<ChatController>(
                init: Get.put(ChatController()),
                builder: (ChatController cController) {
                  return ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: cController.chat.length,
                      itemBuilder: (context, index) {
                        final cModel0 = cController.chat[index];
                        if (cModel0.chatRoomId != widget.chatRoomId) {
                          return const SizedBox();
                        } else {
                          chatId.add(cModel0.chatId);
                          return Align(
                            alignment: cModel0.userId == ""
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              margin: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              decoration: BoxDecoration(
                                color: cModel0.userId == ""
                                    ? Colors.amber
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                cModel0.conversation,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }
                      });
                }),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      width: MediaQuery.of(context).size.width - 45,
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                            hintText: "Type your message..."),
                      )),
                  IconButton(
                    onPressed: () {
                      final cModel = ChatModel(
                          chatRoomId: widget.chatRoomId,
                          vendorId: widget.vendorId,
                          userId: '',
                          date: Timestamp.fromDate(DateTime.now()),
                          conversation: messageController.text);

                      ChatFirestoreDb.addChat(cModel);
                      messageController.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: primaryColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
