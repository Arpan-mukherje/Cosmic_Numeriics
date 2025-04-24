import 'package:cosmic_numeriics/model/commentModel.dart';
import 'package:cosmic_numeriics/services/firebase_service/firestore_services.dart';
import 'package:flutter/material.dart';

// import '../../model/commentModel.dart';

// class CommentScreen extends StatefulWidget {
//   final PostId;
//   const CommentScreen({super.key, required this.PostId});

//   @override
//   State<CommentScreen> createState() => _CommentScreenState();
// }

// class _CommentScreenState extends State<CommentScreen> {
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController _commentController = TextEditingController();
//     void _submitComment() async {
//       final String comment = _commentController.text.trim();
//       if (comment.isNotEmpty) {
//         await StorageServices.commentPost(
//           comment: comment,
//           postId: widget.PostId,
//         );
//       }
//     }

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 242, 222, 1),
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 30,
//           ),
//           TextField(
//             controller: _commentController,
//             decoration: InputDecoration(hintText: "comment"),
//           ),
//           GestureDetector(
//             onTap: () {
//               _submitComment();
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey), // Set border color
//                 borderRadius: BorderRadius.circular(20),
//                 gradient: const LinearGradient(
//                     colors: [Color.fromARGB(255, 31, 23, 145), Colors.blue]),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               width: 290,
//               height: 40,
//               child: const Center(
//                 child: Text(
//                   'click to post',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//               child: StreamBuilder<List<CommentModel>>(
//             stream: StorageServices.getComments(widget.PostId),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               }

//               if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return const Text('No comments available');
//               }

//               final comments = snapshot.data!;

//               return ListView.builder(
//                 itemCount: comments.length,
//                 itemBuilder: (context, index) {
//                   final commentData = comments[index];

//                   final commentText = commentData.name.toString() ?? "";
//                   final commenterName = commentData.comment.toString() ?? "";

//                   return SizedBox(
//                     height: 100,
//                     child: Row(
//                       children: [
//                         CircleAvatar(
//                           child: Image.network(commentData.profilepic),
//                         ),
//                         SizedBox(
//                           height: 200,
//                           width: 200,
//                           child: ListTile(
//                             title: Text(commentText),
//                             subtitle: Text(commenterName),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//           ))
//         ],
//       ),
//     );
//   }
// }
class CommentScreen extends StatefulWidget {
  final String postId;
  const CommentScreen({Key? key, required this.postId}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController _commentController = TextEditingController();
  String? _replyToCommentId;

  void _submitComment() async {
    final String comment = _commentController.text.trim();
    if (comment.isNotEmpty) {
      await StorageServices.commentPost(
        comment: comment,
        postId: widget.postId,
        parentCommentId: _replyToCommentId,
      );
      _commentController.clear();
      setState(() {
        _replyToCommentId = null;
      });
    }
  }

  Widget _buildComment(CommentModel comment, {int indentLevel = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: indentLevel * 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(comment.profilepic),
            ),
            title: Text(comment.name),
            subtitle: Text(comment.comment),
            trailing: IconButton(
              icon: Icon(Icons.reply),
              onPressed: () {
                setState(() {
                  _replyToCommentId = comment.commentId;
                });
              },
            ),
          ),
          StreamBuilder<List<CommentModel>>(
            stream:
                StorageServices.getReplies(widget.postId, comment.commentId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SizedBox.shrink();
              }

              final replies = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: replies.length,
                itemBuilder: (context, index) {
                  final reply = replies[index];
                  return _buildComment(reply, indentLevel: indentLevel + 1);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 222, 1),
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: _replyToCommentId == null ? "Comment" : "Reply",
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _submitComment,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<CommentModel>>(
              stream: StorageServices.getComments(widget.postId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No comments available');
                }

                final comments = snapshot.data!;
                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return _buildComment(comment);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
