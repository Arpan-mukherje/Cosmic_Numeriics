import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmic_numeriics/views/chat_section/chatlist_screen.dart';
import 'package:cosmic_numeriics/model/postModel.dart';
import 'package:cosmic_numeriics/services/provider/community_text_post_caption_readmore_readless_provider.dart';
import 'package:cosmic_numeriics/views/community/post_screen.dart';
import 'package:cosmic_numeriics/services/firebase_service/firestore_services.dart';
import 'package:cosmic_numeriics/views/community/profile_page.dart';
import 'package:cosmic_numeriics/views/community/search_screen.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
import 'package:cosmic_numeriics/widget/community_widgets/article_post_card.dart';
import 'package:cosmic_numeriics/widget/community_widgets/post_card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../services/sharedPrefarence/shared_services.dart';

class FeedSection extends StatefulWidget {
  //%%%%%**** MAKE IT RESPONSIVE*****$$$$
  const FeedSection({super.key});

  @override
  State<FeedSection> createState() => _FeedSectionState();
}

class _FeedSectionState extends State<FeedSection> {
  bool isRun = true;
  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isRun = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    log("Rebuild2");
    String name = SharedServices.getUserData().name.toString();
    String profilepic = SharedServices.getUserData().profilePic.toString();
    String numoNo = SharedServices.getUserData().numerologyNumber.toString();
    "https://firebasestorage.googleapis.com/v0/b/numerology-e7982.appspot.com/o/constant-images%2Fprofile.png?alt=media&token=44a2aa84-6168-47a2-8f08-ffd7d50bc927";

    String formatDate(Timestamp timestamp) {
      DateTime dateTime = timestamp.toDate();
      return DateFormat('d MMMM').format(dateTime);
    }

    final User? id = FirebaseAuth.instance.currentUser;
    // var height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag: "btn2",
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChatListScreen()));
          }),
      backgroundColor: const Color.fromRGBO(255, 242, 222, 1),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Center(
            child: isRun
                ? Shimmer.fromColors(
                    baseColor: const Color.fromRGBO(224, 224, 224, 1),
                    highlightColor: const Color.fromRGBO(245, 245, 245, 1),
                    //  enabled: _enabled,
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 48.0.w,
                              height: 48.0.h,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    height: 8.0.h,
                                    color: Colors.white,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 8.0.h,
                                    color: Colors.white,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                  ),
                                  Container(
                                    width: 40.0.w,
                                    height: 8.0.h,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      itemCount: 20,
                    ),
                  )
                : Column(
                    children: [
                      DecorativeAppBar(
                        barHeight: MediaQuery.of(context).size.height * 0.11,
                        barPad: MediaQuery.of(context).size.height * 0.09,
                        radii: 18,
                        background: const Color.fromARGB(255, 255, 242, 222),
                        gradient1: const Color.fromARGB(255, 192, 40, 114),
                        gradient2: const Color.fromARGB(255, 255, 154, 111),
                        extra: Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10.h,
                              right: 0.15.sw,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Numero Commynity",
                                      style: GoogleFonts.inter(
                                          color: Colors.white,
                                          letterSpacing: 1.0,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      log("message");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (contest) =>
                                                  const SearchView()));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 30.r,
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                        size: 28.sp,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5, top: 5, bottom: 10),
                        child: Container(
                          height: 70.h,
                          // width: 500,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage(
                                                        userId: FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid,
                                                        name: name,
                                                        profileImage:
                                                            profilepic,
                                                        numoNO: numoNo,
                                                      )));
                                        },
                                        child: CircleAvatar(
                                          radius: 25,
                                          child: Image.network(
                                            profilepic,
                                            height: 30.h,
                                            width: 30.w,
                                          ),
                                        )),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PostScreen(
                                                      typeofpage: "file",
                                                    )));
                                        log('Button tapped!');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromRGBO(71, 1,
                                                  35, 1)), // Set border color
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        width: 290.w,
                                        height: 40.h,
                                        child: const Center(
                                          child: Text(
                                            'Click to post',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color:
                                                  Color.fromRGBO(71, 1, 35, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: StorageServices.getUploadPostData(),
                          builder: (context,
                              AsyncSnapshot<List<PostModel>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              log('Error: ${snapshot.error}');
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (builder, index) {
                                    final post = snapshot.data![index];
                                    log(post.imageuRL.toString());
                                    if (post.imageuRL[0].toString() ==
                                        "Text_post") {
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
                                                    builder: (context) =>
                                                        ProfilePage(
                                                          userId: post.userId,
                                                          name: post.name,
                                                          profileImage:
                                                              post.profilePic,
                                                          numoNO: post
                                                              .numorologynumber,
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
                                          StorageServices.likePost(
                                              post.postId, post.likes);
                                        },
                                        isLiked: post.likes.contains(id!.uid),
                                        postId: post.postId,
                                        onNavigate: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage(
                                                        userId: post.userId,
                                                        name: post.name,
                                                        profileImage:
                                                            post.profilePic,
                                                        numoNO: post
                                                            .numorologynumber,
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
                      )
                    ],
                  )),
      ),
    );
  }
}
