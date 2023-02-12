import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/constants/chat_firestore_db.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/constants/customer_order_firestoredb.dart';
import 'package:vendor/constants/transaction_db.dart';
import 'package:vendor/constants/user_refund_firestore.dart';
import 'package:vendor/controllers/chat_controller.dart';
import 'package:vendor/controllers/new_order_detail_controller.dart';
import 'package:vendor/controllers/user_refund_controller.dart';
import 'package:vendor/models/chat_model.dart';
import 'package:vendor/models/customer_cart_model.dart';
import 'package:vendor/models/transaction_model.dart';
import 'package:vendor/screens/home_screen.dart';

import '../constants/order_history_firebasedb.dart';

class ChatScreen extends StatefulWidget {
  final String vendorId, customerId, chatRoomId, orderNumber, totalPrice;
  const ChatScreen({
    super.key,
    required this.vendorId,
    required this.customerId,
    required this.chatRoomId,
    required this.orderNumber,
    required this.totalPrice,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  List chatId = [];

  @override
  Widget build(BuildContext context) {
    List<MyCartModel> myCartList = [];
    String getCartId = "";

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

                                        // //refund money
                                        // print(customerWalletAmount);

                                        double refundAmount = double.parse(
                                                widget.totalPrice) +
                                            double.parse(customerWalletAmount);
                                        UserRefundFirestoreDb.refundAmount(
                                            refundAmount.toStringAsFixed(2),
                                            widget.customerId);

                                        final transactionModel =
                                            TransactionModel(
                                                date: Timestamp.fromDate(
                                                    DateTime.now()),
                                                amount: double.parse(
                                                        refundAmount
                                                            .toStringAsFixed(2))
                                                    .toStringAsFixed(2),
                                                code: 3,
                                                uid: widget.customerId);
                                        TransactionFirestoreDb.addTransaction(
                                            transactionModel);
                                        /**
                                         * 1. update code
                                         * 2. delete all data
                                         */
                                        for (var e in myCartList) {
                                          OrderHistoryFirestoreDb
                                              .addOrderHistory(e);
                                        }

                                        NewOrderFirestoreDb.deleteOrderList(
                                            widget.orderNumber, getCartId);
                                        NewOrderFirestoreDb.deleteOrder(
                                            widget.orderNumber);
                                        Navigator.pop(context);
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
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Stack(
        children: [
          GetX<OrderItemController2>(
              init: Get.put(
                  OrderItemController2(orderNumber: widget.orderNumber)),
              builder: (OrderItemController2 ocController) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: ocController.order.length,
                    itemBuilder: (context, index) {
                      getCartId = ocController.order[index].myCartId!;
                      if (myCartList.isEmpty ||
                          myCartList.length < ocController.order.length) {
                        myCartList.add(ocController.order[index]);
                      }
                      return const SizedBox();
                    });
              }),
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
