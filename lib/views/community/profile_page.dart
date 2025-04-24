import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmic_numeriics/model/postModel.dart';
import 'package:cosmic_numeriics/services/firebase_service/firestore_services.dart';
import 'package:cosmic_numeriics/services/provider/community_text_post_caption_readmore_readless_provider.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
import 'package:cosmic_numeriics/widget/community_widgets/article_post_card.dart';
import 'package:cosmic_numeriics/widget/community_widgets/post_card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final String profileImage;
  final String name;
  final String userId;
  final String numoNO;
  const ProfilePage({
    Key? key,
    required this.profileImage,
    required this.name,
    required this.userId,
    required this.numoNO,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int postlen = 0;
  int followersL = 0;
  int followingL = 0;
  bool isfollow = false;
  bool isloading = false;
  final User? id = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _checkIfFollowing();
  }

  Future<void> _checkIfFollowing() async {
    try {
      DocumentSnapshot userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(id!.uid)
          .get();

      DocumentSnapshot profileSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      List following = (userSnap.data()! as dynamic)['following'] ?? [];
      List followers = (profileSnap.data()! as dynamic)['followers'] ?? [];

      setState(() {
        isfollow = followers.contains(id!.uid);
        followingL = following.length;
        followersL = followers.length;
      });
    } catch (e) {
      log("Error in _checkIfFollowing: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    String formatDate(Timestamp timestamp) {
      DateTime dateTime = timestamp.toDate();
      return DateFormat('d MMMM').format(dateTime);
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 242, 222, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecorativeAppBar(
              barHeight: MediaQuery.of(context).size.height * 0.19,
              barPad: MediaQuery.of(context).size.height * 0.17,
              radii: 20,
              background: const Color.fromARGB(255, 255, 242, 222),
              gradient1: const Color.fromARGB(255, 192, 40, 114),
              gradient2: const Color.fromARGB(255, 255, 154, 111),
              extra: Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.07, left: height * 0.03),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.07, left: height * 0.02),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(" My profile",
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  letterSpacing: 1.0,
                                  fontSize: height * 0.03,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CircleAvatar(
                    radius: 60.r,
                    child: Image.network(widget.profileImage),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
              child: Text(
                widget.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
              child: Text(
                "Numerology Number - ${widget.numoNO}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
              child: Text(
                "$followersL + Followers",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FirebaseAuth.instance.currentUser!.uid != widget.userId
                      ? !isfollow
                          ? Container(
                              height: 35,
                              width: 0.27.sw,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(158, 18, 86, 1),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  setState(() {
                                    isfollow = true;
                                    followersL++;
                                  });
                                  await StorageServices.followuser(
                                      id!.uid, widget.userId);
                                },
                                borderRadius: BorderRadius.circular(16.0),
                                child: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Follow',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      SizedBox(width: 2.0),
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: 35,
                              width: 0.27.sw,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(158, 18, 86, 1),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  setState(() {
                                    isfollow = false;
                                    followersL--;
                                  });
                                  await StorageServices.followuser(
                                      id!.uid, widget.userId);
                                },
                                borderRadius: BorderRadius.circular(16.0),
                                child: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'unfollow',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      SizedBox(width: 2.0),
                                      Icon(
                                        Icons.cancel,
                                        color: Colors.white,
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                      : Container(),
                  SizedBox(
                    width: 0.06.sw,
                  ),
                  FirebaseAuth.instance.currentUser!.uid != widget.userId
                      ? Container(
                          height: 35.h,
                          width: 0.27.sw,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(158, 18, 86, 1),
                            borderRadius: BorderRadius.circular(16.0),
                            //border: Border.all(),
                          ),
                          child: InkWell(
                            onTap: () {
                              // Add your onPressed logic here
                            },
                            borderRadius: BorderRadius.circular(16.0),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Chat',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  SizedBox(width: 4.0),
                                  Icon(Icons.chat_bubble_outline,
                                      color: Colors.white, size: 15),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            const Divider(
              color: Color.fromRGBO(158, 18, 86, 1),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              child: Text(
                "Recent Posts",
                style: GoogleFonts.poppins(
                    fontSize: 21, fontWeight: FontWeight.w500),
              ),
            ),
            StreamBuilder(
              stream: StorageServices.getDataForProfilePage(widget.userId),
              builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  log('Error: ${snapshot.error}');
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (builder, index) {
                        final post = snapshot.data![index];
                        // log(post.imageuRL);
                        if (post.imageuRL[0] == "Text_post") {
                          var date = formatDate(post.time);
                          return ChangeNotifierProvider(
                            create: (_) =>
                                CommynityPostCaptionReadmoreReadless(),
                            child: ArticlePostCardWidget(
                              desc: post.desc,
                              name: post.name,
                              date: date,
                              likes: post.likes,
                              profilepic: post.profilePic,
                              onLike: () {
                                StorageServices.likePost(
                                    post.postId, post.likes);
                              },
                              isLiked: post.likes.contains(id!.uid),
                              postId: post.postId,
                              onNavigate: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfilePage(
                                              userId: post.userId,
                                              name: post.name,
                                              profileImage: post.profilePic,
                                              numoNO: post.numorologynumber,
                                            )));
                              },
                              userId: post.userId,
                              uniqueId: post.uniqueId,
                            ),
                          );
                        } else {
                          var date = formatDate(post.time);
                          return PostCardWidget(
                            imageUrl: post.imageuRL,
                            desc: post.desc,
                            name: post.name,
                            date: date,
                            likes: post.likes,
                            profilepic: post.profilePic,
                            onLike: () {
                              StorageServices.likePost(post.postId, post.likes);
                            },
                            isLiked: post.likes.contains(id!.uid),
                            postId: post.postId,
                            onNavigate: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage(
                                            userId: post.userId,
                                            name: post.name,
                                            profileImage: post.profilePic,
                                            numoNO: post.numorologynumber,
                                          )));
                            },
                            userId: post.userId,
                            uniqueId: post.uniqueId,
                          );
                        }
                      });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
