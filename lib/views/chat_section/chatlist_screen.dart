import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmic_numeriics/views/chat_section/chat_screen.dart';
import 'package:cosmic_numeriics/services/sharedPrefarence/shared_services.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/appbar_widget.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DecorativeAppBar(
              barHeight: MediaQuery.of(context).size.height * 0.24,
              barPad: MediaQuery.of(context).size.height * 0.2,
              radii: 30,
              background: const Color.fromARGB(255, 255, 242, 222),
              gradient1: const Color.fromARGB(255, 192, 40, 114),
              gradient2: const Color.fromARGB(255, 255, 154, 111),
              extra: appbar("assets/man_4202843.png", "Chat", context, () {
                Navigator.pop(context);
              }),
            ),
            _buildUserList(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          );
        }

        List<Widget>? userList = [];
        List<Future<Map<String, dynamic>>> userFutures = snapshot.data!.docs
            .where((doc) => doc['email'] != SharedServices.getUserData().email)
            .map((doc) => _buildUserListItemWithTimestamp(doc))
            .toList();

        return FutureBuilder<List<Map<String, dynamic>>>(
          future: Future.wait(userFutures),
          builder: (context, userSnapshots) {
            if (userSnapshots.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              );
            }
            if (userSnapshots.hasError) {
              return const Text('Error');
            }
            userSnapshots.data!.sort((a, b) {
              return b['timestamp'].compareTo(a['timestamp']);
            });

            userList = userSnapshots.data!
                .map((user) => user['widget'])
                .cast<Widget>()
                .toList();

            return Container(
              color: const Color.fromARGB(255, 255, 242, 222),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: userList!,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<Map<String, dynamic>> _buildUserListItemWithTimestamp(
      DocumentSnapshot document) async {
    Map<String, dynamic> chatRoom = document.data() as Map<String, dynamic>;

    String agentEmail = chatRoom['email'];
    String agentuserName = chatRoom['name'];
    String profilePic = chatRoom["profile-pic"];
    List<String> ids = [agentEmail, SharedServices.getUserData().email!];
    ids.sort();
    String chatRoomId = ids.join("_");

    QuerySnapshot messageSnapshot = await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    String latestMessage = 'No messages';
    Timestamp latestTimestamp = Timestamp.fromMillisecondsSinceEpoch(0);

    if (messageSnapshot.docs.isNotEmpty) {
      latestMessage = messageSnapshot.docs.first['message'] ?? 'No message';
      latestTimestamp = messageSnapshot.docs.first['timestamp'];
    }

    Widget userWidget = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 191, 191, 191),
              blurRadius: 3,
              offset: Offset(-1, 1),
            ),
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(
              radius: 20, backgroundImage: NetworkImage(profilePic)),
          title: Text(agentuserName,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(latestMessage),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  username: agentuserName,
                  email: agentEmail,
                ),
              ),
            );
          },
        ),
      ),
    );

    return {
      'widget': userWidget,
      'timestamp': latestTimestamp,
    };
  }
}
