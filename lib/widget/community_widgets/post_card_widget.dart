import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cosmic_numeriics/services/firebase_service/firestore_services.dart';
import 'package:cosmic_numeriics/views/community/comment_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostCardWidget extends StatefulWidget {
  final String postId;
  final List<String>? imageUrl;
  final String? desc;
  final String? userId;
  final String? name;
  final String? date;
  final String? profilepic;
  final String uniqueId;
  final List<dynamic>? likes;
  final VoidCallback onLike;
  final bool isLiked;
  final VoidCallback? onNavigate;
  const PostCardWidget({
    Key? key,
    this.imageUrl,
    this.desc,
    this.name,
    this.date,
    this.likes,
    this.profilepic,
    required this.onLike,
    required this.isLiked,
    required this.postId,
    this.onNavigate,
    this.userId,
    required this.uniqueId,
  }) : super(key: key);

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget>
    with TickerProviderStateMixin {
  bool showFullTextForFilePost = true;
  int _current = 0;

  final CarouselSliderController _carouselController =
      CarouselSliderController();

  void _showDialog(BuildContext context, VoidCallback delete) {
    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          content: const Text("Choose an action"),
          actions: [
            FirebaseAuth.instance.currentUser!.uid == widget.userId
                ? TextButton(
                    onPressed: () {
                      delete();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Delete",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  )
                : Container(),
            FirebaseAuth.instance.currentUser!.uid != widget.userId
                ? TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showReportDialog(context);
                    },
                    child: const Text(
                      "Report",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  )
                : Container(),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        );
      }),
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: const Text("Report Post"),
          content: const Column(
            children: [
              Text("Please provide a reason for reporting this post:"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
            ),
            TextButton(
              onPressed: () {
                StorageServices.reportPost(widget.uniqueId, "test 3 for web");
                Navigator.of(context).pop();
              },
              child: const Text(
                "Report",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //  double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.onNavigate!();
                        },
                        child: CircleAvatar(
                          radius: 20,
                          child: Image.network(
                            widget.profilepic ?? "",
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.onNavigate!();
                              },
                              child: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.456,
                                child: Text(
                                  widget.name ?? "",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 0.04.sw,
                                      color:
                                          const Color.fromRGBO(71, 1, 35, 1)),
                                ),
                              ),
                            ),
                            Text(
                              widget.date ?? "",
                              style: GoogleFonts.poppins(
                                color: const Color.fromRGBO(71, 1, 35, 1),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            _showDialog(context, () {
                              StorageServices.deletePost(
                                  widget.postId, widget.imageUrl!);
                            });
                          },
                          child: const Icon(
                            Icons.more_vert_outlined,
                            color: Color.fromRGBO(71, 1, 35, 1),
                          ))
                    ],
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, top: 5, right: 10),
                    child: Text(
                      textAlign: TextAlign.justify,
                      widget.desc ?? "",
                      maxLines:
                          showFullTextForFilePost ? 4 : widget.desc!.length,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        color: const Color.fromRGBO(71, 1, 35, 1),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                if (widget.desc != null && widget.desc!.trim().isNotEmpty)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showFullTextForFilePost = !showFullTextForFilePost;
                      });
                    },
                    child: Text(
                      showFullTextForFilePost ? 'Read more' : 'Read less',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 51, 82, 255),
                          fontSize: 12 // Change color as needed
                          ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: height * 0.35,
                width: double.infinity,
                child: widget.imageUrl!.length == 1
                    ? PhotoView(
                        imageProvider:
                            CachedNetworkImageProvider(widget.imageUrl![0]),
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.covered * 4,
                        initialScale: PhotoViewComputedScale.contained,
                      )
                    : Column(
                        children: [
                          CarouselSlider.builder(
                            carouselController: _carouselController,
                            options: CarouselOptions(
                              height: height * 0.32,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              },
                            ),
                            itemCount: widget.imageUrl!.length,
                            itemBuilder: (context, index, realIdx) {
                              return PhotoViewGallery.builder(
                                itemCount: widget.imageUrl!.length,
                                builder: (context, index) {
                                  return PhotoViewGalleryPageOptions(
                                    imageProvider: CachedNetworkImageProvider(
                                        widget.imageUrl![index]),
                                    minScale: PhotoViewComputedScale.contained,
                                    maxScale:
                                        PhotoViewComputedScale.covered * 4,
                                  );
                                },
                                pageController:
                                    PageController(initialPage: _current),
                                onPageChanged: (index) {
                                  setState(() {
                                    _current = index;
                                  });
                                },
                              );
                            },
                          ),
                          SizedBox(height: 10.h),
                          AnimatedSmoothIndicator(
                            activeIndex: _current,
                            count: widget.imageUrl!.length,
                            effect: const WormEffect(
                              dotWidth: 10.0,
                              dotHeight: 10.0,
                              activeDotColor: Color.fromARGB(255, 158, 18, 86),
                              dotColor: Colors.grey,
                            ),
                            onDotClicked: (index) {
                              _carouselController.animateToPage(index);
                            },
                          ),
                        ],
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.onLike();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Icon(
                            widget.isLiked
                                ? Icons.thumb_up
                                : Icons.thumb_up_outlined,
                            size: 33,
                            color: widget.isLiked
                                ? const Color.fromRGBO(71, 1, 35, 1)
                                : const Color.fromRGBO(71, 1, 35, 1),
                          ),
                          Text(
                            '${widget.likes!.length} Likes',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CommentScreen(
                                postId: widget.postId,
                                // postId: widget.postId,
                              )));
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 18.0),
                      child: Icon(
                        Icons.comment_outlined,
                        size: 32,
                        color: Color.fromRGBO(71, 1, 35, 1),
                      ),
                    ),
                  ),
                  // const SizedBox(width: 20),
                  // const Icon(
                  //   Icons.send,
                  //   size: 33,
                  //   color: Colors.grey,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
