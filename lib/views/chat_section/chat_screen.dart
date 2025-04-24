import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmic_numeriics/views/chat_section/chat_buble.dart';
import 'package:cosmic_numeriics/views/chat_section/chat_screen_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  final String username;
  final String email;

  const ChatScreen({
    super.key,
    required this.username,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final ChatScreenController controller = Get.put(ChatScreenController());
    controller.agentEmail.value = email;
    controller.username.value = username;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          username,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: GetBuilder<ChatScreenController>(
        builder: (_) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            // image: DecorationImage(
            //     image: AssetImage('assets/chat_background.jpg'),
            //     fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: _buildMessageList(controller),
                ),
              ),
              _buildMessageInput(controller, email, username),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList(ChatScreenController controller) {
    return StreamBuilder(
      stream: controller.chatService.getMessagesService(email),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator(color: Colors.blue)),
          );
        }
        return ListView.builder(
          controller: controller.scrollController,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final data = snapshot.data!.docs[index];
            final messageDate = (data['timestamp'] as Timestamp).toDate();
            final prevMessage =
                index > 0 ? snapshot.data!.docs[index - 1] : null;
            final DateTime prevMessageDate = prevMessage != null
                ? (prevMessage['timestamp'] as Timestamp).toDate()
                : messageDate;
            if (prevMessage == null ||
                messageDate.day != prevMessageDate.day ||
                messageDate.difference(prevMessageDate).inDays > 0) {
              controller.updateDate(messageDate);
              return Column(
                children: [
                  DateBubble(date: controller.date.value),
                  _buildMessageItem(controller, snapshot.data!.docs[index])
                ],
              );
            }
            return _buildMessageItem(controller, snapshot.data!.docs[index]);
          },
        );
      },
    );
  }

  _buildMessageItem(
      ChatScreenController controller, DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    DateTime timestamp = (data['timestamp'] as Timestamp).toDate();
    String time = formatTime(timestamp);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ChatBubbleService(
        message: data['message'],
        isSender:
            data['senderEmail'] == FirebaseAuth.instance.currentUser!.email,
        timeAgo: time,
      ),
    );
  }
}

Widget _buildMessageInput(
    ChatScreenController controller, String email, String username) {
  return Padding(
    padding: const EdgeInsets.only(
      right: 16.0,
      left: 16.0,
      bottom: 16.0,
    ),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Material(
              borderRadius: BorderRadius.circular(16),
              elevation: 5,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.messageController,
                      minLines: 1,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Enter Message',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(() => controller.isLoading.value
            ? const CircularProgressIndicator()
            : IconButton(
                onPressed: () => controller.sendMessage(),
                icon: const Icon(Icons.send),
              )),
      ],
    ),
  );
}

String formatTime(DateTime time) {
  final now = DateTime.now();
  final isToday =
      now.day == time.day && now.month == time.month && now.year == time.year;
  final isYesterday = now.day - 1 == time.day &&
      now.month == time.month &&
      now.year == time.year;
  if (isToday) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  } else if (isYesterday) {
    return "Yesterday ${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  } else {
    return "${time.day}/${time.month}/${time.year} ${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }
}

class DateBubble extends StatelessWidget {
  final String date;

  const DateBubble({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              date,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
