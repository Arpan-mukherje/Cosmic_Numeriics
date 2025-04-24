import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmic_numeriics/views/community/profile_page.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  var searchName = "";
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 242, 222, 1),
        body: Column(
          children: [
            DecorativeAppBar(
              barHeight: MediaQuery.of(context).size.height * 0.1,
              barPad: MediaQuery.of(context).size.height * 0.07,
              radii: 18,
              background: const Color.fromARGB(255, 255, 242, 222),
              gradient1: const Color.fromARGB(255, 192, 40, 114),
              gradient2: const Color.fromARGB(255, 255, 154, 111),
              extra: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 15),
                  child: Text("Search here...",
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          letterSpacing: 1.0,
                          fontSize: height * 0.023,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: SizedBox(
                height: 40,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchName = value;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      )),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .orderBy('searchName')
                      .startAt([searchName.toLowerCase()]).endAt(
                          [searchName.toLowerCase() + "\uf8ff"]).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage(
                                            profileImage: data['profile-pic'],
                                            userId: data['userId'],
                                            name: data['name'],
                                            numoNO: data['numerologyNumber']
                                                .toString(),
                                          )),
                                );
                              },
                              leading: CircleAvatar(
                                radius: 24,
                                backgroundImage:
                                    NetworkImage(data['profile-pic']),
                              ),
                              title: Text(data['name']),
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
