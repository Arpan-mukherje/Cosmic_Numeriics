import 'package:cosmic_numeriics/views/chat_section/chat_service.dart';
import 'package:cosmic_numeriics/views/chat_section/user_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChatScreenController extends GetxController {
  var agentEmail = "".obs;
  var username = "".obs;

  // ChatScreenController(this.agentEmail, this.username);

  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final ScrollController scrollController = ScrollController();
  final UserController userController = Get.put(UserController());

  var isLoading = false.obs;
  var date = "".obs;

  @override
  void onInit() {
    super.onInit();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void sendMessage() async {
    //log(agentEmail);
    if (messageController.text.isNotEmpty) {
      isLoading(true);
      update();
      await chatService.sendMessage(
          agentEmail.value, messageController.text, username.value);
      messageController.clear();
      _scrollToBottom();
      isLoading(false);
      update();
    }
  }

  Future<bool> onWillPop(BuildContext context) async {
    Navigator.pop(context);
    Get.delete<ChatScreenController>();
    return true;
  }

  void updateDate(DateTime dateTime) {
    DateTime now = DateTime.now();
    if (dateTime.year == now.year && dateTime.month == now.month) {
      if (now.day == dateTime.day) {
        date("Today");
      } else if (now.day - 1 == dateTime.day) {
        date("Yesterday");
      } else {
        date("${dateTime.day}/${dateTime.month}/${dateTime.year}");
      }
    } else if (now.day == 1 &&
            (now.month - 1 == dateTime.month && dateTime.year == now.year) ||
        now.month == 1 && dateTime.year == now.year - 1) {
      date("Yesterday");
    } else {
      date("${dateTime.day}/${dateTime.month}/${dateTime.year}");
    }
  }
}
