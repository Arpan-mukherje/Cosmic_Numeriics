import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBubbleService extends StatelessWidget {
  final String message;
  final String timeAgo;
  final bool isSender;

  const ChatBubbleService({
    super.key,
    required this.message,
    required this.isSender,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    var alignment = (isSender) ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
        child: Column(
          crossAxisAlignment:
              (isSender) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment:
              (isSender) ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: isSender
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))
                    : const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                color: isSender ? const Color(0xFF08215E) : Colors.green,
              ),
              child: Text(
                message,
                style: TextStyle(
                    fontSize: 16, color: isSender ? Colors.red : Colors.black),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(timeAgo),
            ),
          ],
        ),
      ),
    );
  }
}

// chat bubble for banners
class BannerChatBubble extends StatelessWidget {
  final String imageUrl;
  final String message;
  final String timeAgo;

  const BannerChatBubble({
    super.key,
    required this.imageUrl,
    required this.message,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 290,
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue.shade100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(imageUrl, height: 185, width: 185),
                Text(
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  message,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(timeAgo),
          ),
        ],
      ),
    );
  }
}

class CallBubble extends StatelessWidget {
  final String message;
  final String timeAgo;
  final bool isOutgoing;
  const CallBubble(
      {super.key,
      required this.message,
      required this.timeAgo,
      required this.isOutgoing});

  @override
  Widget build(BuildContext context) {
    var alignment = (isOutgoing) ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
        child: Column(
          crossAxisAlignment:
              (isOutgoing) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment:
              (isOutgoing) ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: isOutgoing
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))
                      : const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                  color: isOutgoing
                      ? const Color(0xFF08215E)
                      : Colors.blue.shade100,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isOutgoing
                        ? Icon(
                            CupertinoIcons.phone_fill_arrow_up_right,
                            color: Colors.orange,
                          )
                        : Icon(
                            CupertinoIcons.phone_fill_arrow_down_left,
                            color: Colors.green,
                          ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      message,
                      style: TextStyle(
                          fontSize: 16,
                          color:
                              isOutgoing ? Colors.blue.shade100 : Colors.black),
                    )
                  ],
                )),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(timeAgo),
            ),
          ],
        ),
      ),
    );
  }
}
