import 'dart:developer';

import 'package:cosmic_numeriics/widget/appbar_widgets/appbar_widget.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
import 'package:cosmic_numeriics/widget/home_widgets/Pcards.dart';
import 'package:cosmic_numeriics/constant/constants.dart';
import 'package:flutter/material.dart';

class MyLuckyThingsScreen extends StatefulWidget {
  final dobSum;
  const MyLuckyThingsScreen({super.key, required this.dobSum});

  @override
  State<MyLuckyThingsScreen> createState() => _MyLuckyThingsScreenState();
}

class _MyLuckyThingsScreenState extends State<MyLuckyThingsScreen> {
  bool showContainer = false;
  List<Widget> pCardsList = [];
  // List<Widget> dCardsList = [];

  // ignore: non_constant_identifier_names
  void Pnemurologycheck() {
    log("hello----" + widget.dobSum.toString());
    if (widget.dobSum == 1) {
      // dob: dob,
      // dest: destiny.toString(),
      // color: no2LuckyColorShort,
      // no: '2',
      // no1futureh: no2future,
      // no1lifePatneth: no2lifePatnet,
      // gemStone: no2GemStone,
      // luckyDates: no2LuckyDates,
      // character: no2Character,
      pCardsList.add(const PCard(
        dob: "dob",
        dest: "destiny.toString(),",
        color: 'yellow, Orange',
        no: '1',
        no1futureh: no1future,
        no1lifePatneth: no1lifePatnet,
        gemStone: no1GemStone,
        luckyDates: no1LuckyDates,
        character: no1Character,
      ));
    } else if (widget.dobSum == 2) {
      pCardsList.add(const PCard(
        dob: "dob",
        dest: "destiny.toString(),",
        color: 'yellow, Orange',
        no: '2',
        no1futureh: no1future,
        no1lifePatneth: no1lifePatnet,
        gemStone: no2GemStone,
        luckyDates: no2LuckyDates,
        character: no2Character,
      ));
    } else if (widget.dobSum == 3) {
      pCardsList.add(const PCard(
        dob: "dob",
        dest: "destiny.toString(),",
        color: 'yellow, Orange',
        no: '3',
        no1futureh: no1future,
        no1lifePatneth: no1lifePatnet,
        gemStone: no3GemStone,
        luckyDates: no3LuckyDates,
        character: no3Character,
      ));
    } else if (widget.dobSum == 4) {
      pCardsList.add(const PCard(
        dob: "dob",
        dest: "destiny.toString(),",
        color: 'yellow, Orange',
        no: '4',
        no1futureh: no1future,
        no1lifePatneth: no1lifePatnet,
        gemStone: no4GemStone,
        luckyDates: no4LuckyDates,
        character: no4Character,
      ));
    } else if (widget.dobSum == 5) {
      pCardsList.add(const PCard(
        dob: "dob",
        dest: "destiny.toString(),",
        color: 'yellow, Orange',
        no: '5',
        no1futureh: no1future,
        no1lifePatneth: no1lifePatnet,
        gemStone: no5GemStone,
        luckyDates: no5LuckyDates,
        character: no5Character,
      ));
    } else if (widget.dobSum == 6) {
      pCardsList.add(const PCard(
        dob: "dob",
        dest: "destiny.toString(),",
        color: 'yellow, Orange',
        no: '6',
        no1futureh: no1future,
        no1lifePatneth: no1lifePatnet,
        gemStone: no6GemStone,
        luckyDates: no6LuckyDates,
        character: no6Character,
      ));
    } else if (widget.dobSum == 7) {
      pCardsList.add(const PCard(
        dob: "dob",
        dest: "destiny.toString(),",
        color: 'yellow, Orange',
        no: '7',
        no1futureh: no1future,
        no1lifePatneth: no1lifePatnet,
        gemStone: no7GemStone,
        luckyDates: no7LuckyDates,
        character: no7Character,
      ));
    } else if (widget.dobSum == 8) {
      pCardsList.add(const PCard(
        dob: "dob",
        dest: "destiny.toString(),",
        color: 'yellow, Orange',
        no: '8',
        no1futureh: no1future,
        no1lifePatneth: no1lifePatnet,
        gemStone: no8GemStone,
        luckyDates: no8LuckyDates,
        character: no8Character,
      ));
    } else if (widget.dobSum == 9) {
      pCardsList.add(const PCard(
        dob: "dob",
        dest: "destiny.toString(),",
        color: 'yellow, Orange',
        no: '9',
        no1futureh: no1future,
        no1lifePatneth: no1lifePatnet,
        gemStone: no9GemStone,
        luckyDates: no9LuckyDates,
        character: no9Character,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    // Call the Pnemurologycheck method when the widget is initialized
    Pnemurologycheck();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 158, 212, 255),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DecorativeAppBar(
                  barHeight: MediaQuery.of(context).size.height * 0.24,
                  barPad: MediaQuery.of(context).size.height * 0.19,
                  radii: 30,
                  background: const Color.fromARGB(255, 158, 212, 255),
                  gradient1: const Color.fromARGB(255, 6, 190, 182),
                  gradient2: const Color.fromARGB(255, 66, 114, 192),
                  extra: appbar(
                    "assets/man_4202843.png",
                    "My Lucky Things",
                    context,
                    () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Column(
                  children: pCardsList,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
