import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/appbar_widget.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
import 'package:cosmic_numeriics/widget/home_widgets/Dcards.dart';
import 'package:cosmic_numeriics/widget/home_widgets/Pcards.dart';
import 'package:cosmic_numeriics/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../services/provider/show_container.dart';

class DobSection extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const DobSection({Key? key});

  @override
  State<DobSection> createState() => _DobSectionState();
}

class _DobSectionState extends State<DobSection>
    with SingleTickerProviderStateMixin {
  TextEditingController d = TextEditingController();
  TextEditingController m = TextEditingController();
  TextEditingController y = TextEditingController();
  bool showContainer = false;
  List<Widget> pCardsList = [];
  List<Widget> dCardsList = [];

  @override
  void dispose() {
    super.dispose();
    d.dispose();
    m.dispose();
    y.dispose();
  }

  @override
  void initState() {
    super.initState();
    showContainer = false;
  }

  void validity() {
    int? day = int.tryParse(d.text);
    int? month = int.tryParse(m.text);
    int? year = int.tryParse(y.text);

    if (day! > 31) {
      const snackBar = SnackBar(
        content: Text('The value of "DAY" should be between 1 to 31'),
        backgroundColor: Color.fromARGB(255, 229, 74, 74),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (month! > 12) {
      const snackBar = SnackBar(
        content: Text('The value of "MONTH" should be between 1 to 12'),
        backgroundColor: Color.fromARGB(255, 229, 74, 74),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (year! < 4) {
      const snackBar = SnackBar(
        content: Text('The value of "YEAR" should be valid'),
        backgroundColor: Color.fromARGB(255, 229, 74, 74),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      Pnemurologycheck();
    }
  }

  // ignore: non_constant_identifier_names
  void Pnemurologycheck() {
    pCardsList.clear();
    dCardsList.clear();
    int? day = int.tryParse(d.text);
    int? month = int.tryParse(m.text);
    int? year = int.tryParse(y.text);
    int? total = (day! + month! + year!);
    while (total! > 9) {
      total = total.toString().split('').map(int.parse).reduce((a, b) => a + b);
    }
    int? destiny = total;

    int digitSum = day;
    while (digitSum > 9) {
      digitSum =
          digitSum.toString().split('').map(int.parse).reduce((a, b) => a + b);
    }

    String dob = "$day-$month-$year";
    if (digitSum == 1) {
      pCardsList.add(PCard(
        dob: dob,
        dest: destiny.toString(),
        color: no1LuckyColorShort,
        no: '1',
        no1futureh: no1future,
        no1lifePatneth: no1lifePatnet,
        gemStone: no1GemStone,
        luckyDates: no1LuckyDates,
        character: no1Character,
      ));
    } else if (digitSum == 2) {
      pCardsList.add(PCard(
        dob: dob,
        dest: destiny.toString(),
        color: no2LuckyColorShort,
        no: '2',
        no1futureh: no2future,
        no1lifePatneth: no2lifePatnet,
        gemStone: no2GemStone,
        luckyDates: no2LuckyDates,
        character: no2Character,
      ));
    } else if (digitSum == 3) {
      pCardsList.add(PCard(
        dob: dob,
        dest: destiny.toString(),
        color: no3LuckyColorShort,
        no: '3',
        no1futureh: no3future,
        no1lifePatneth: no3lifePatnet,
        gemStone: no3GemStone,
        luckyDates: no3LuckyDates,
        character: no3Character,
      ));
    } else if (digitSum == 4) {
      pCardsList.add(PCard(
        dob: dob,
        dest: destiny.toString(),
        color: no4LuckyColorShort,
        no: '4',
        no1futureh: no4future,
        no1lifePatneth: no4lifePatnet,
        gemStone: no4GemStone,
        luckyDates: no4LuckyDates,
        character: no4Character,
      ));
    } else if (digitSum == 5) {
      pCardsList.add(PCard(
        dob: dob,
        dest: destiny.toString(),
        color: no5LuckyColorShort,
        no: '5',
        no1futureh: no5future,
        no1lifePatneth: no5lifePatnet,
        gemStone: no5GemStone,
        luckyDates: no5LuckyDates,
        character: no5Character,
      ));
    } else if (digitSum == 6) {
      pCardsList.add(PCard(
        dob: dob,
        dest: destiny.toString(),
        color: no6LuckyColorShort,
        no: '6',
        no1futureh: no6future,
        no1lifePatneth: no6lifePatnet,
        gemStone: no6GemStone,
        luckyDates: no6LuckyDates,
        character: no6Character,
      ));
    } else if (digitSum == 7) {
      pCardsList.add(PCard(
        dob: dob,
        dest: destiny.toString(),
        color: no7LuckyColorShort,
        no: '7',
        no1futureh: no7future,
        no1lifePatneth: no7lifePatnet,
        gemStone: no7GemStone,
        luckyDates: no7LuckyDates,
        character: no7Character,
      ));
    } else if (digitSum == 8) {
      pCardsList.add(PCard(
        dob: dob,
        dest: destiny.toString(),
        color: no8LuckyColorShort,
        no: '8',
        no1futureh: no8future,
        no1lifePatneth: no8lifePatnet,
        gemStone: no8GemStone,
        luckyDates: no8LuckyDates,
        character: no8Character,
      ));
    } else if (digitSum == 9) {
      pCardsList.add(PCard(
        dob: dob,
        dest: destiny.toString(),
        color: no9LuckyColorShort,
        no: '9',
        no1futureh: no9future,
        no1lifePatneth: no9lifePatnet,
        gemStone: no9GemStone,
        luckyDates: no8LuckyDates,
        character: no9Character,
      ));
    }

    if (destiny == 1) {
      dCardsList.add(const DCard(
        no: '1',
        no1destinycharh: no1destinychar,
        no1destinyfutureh: no1destinyfuture,
        no1destinylifepartnerh: no1destinylifepartner,
        color: no1LuckyColorShort,
        character: no1destinychar,
        gemStone: no1GemStone,
        luckyDates: no1LuckyDates,
      ));
    } else if (destiny == 2) {
      dCardsList.add(const DCard(
        no: '2',
        no1destinycharh: no2destinychar,
        no1destinyfutureh: no2destinyfuture,
        no1destinylifepartnerh: no2destinylifepartner,
        color: no2LuckyColorShort,
        character: no2destinychar,
        gemStone: no2GemStone,
        luckyDates: no2LuckyDates,
      ));
    } else if (destiny == 3) {
      dCardsList.add(const DCard(
        no: '3',
        no1destinycharh: no3destinychar,
        no1destinyfutureh: no3destinyfuture,
        no1destinylifepartnerh: no3destinylifepartner,
        color: no3LuckyColorShort,
        character: no3destinychar,
        gemStone: no3GemStone,
        luckyDates: no3LuckyDates,
      ));
    } else if (destiny == 4) {
      dCardsList.add(const DCard(
        no: '4',
        no1destinycharh: no4destinychar,
        no1destinyfutureh: no4destinyfuture,
        no1destinylifepartnerh: no4destinylifepartner,
        color: no4LuckyColorShort,
        character: no4destinychar,
        gemStone: no4GemStone,
        luckyDates: no4LuckyDates,
      ));
    } else if (destiny == 5) {
      dCardsList.add(const DCard(
        no: '5',
        no1destinycharh: no5destinychar,
        no1destinyfutureh: no5destinyfuture,
        no1destinylifepartnerh: no5destinylifepartner,
        color: no5LuckyColorShort,
        character: no5destinychar,
        gemStone: no5GemStone,
        luckyDates: no5LuckyDates,
      ));
    } else if (destiny == 6) {
      dCardsList.add(const DCard(
        no: '6',
        no1destinycharh: no6destinychar,
        no1destinyfutureh: no6destinyfuture,
        no1destinylifepartnerh: no6destinylifepartner,
        color: no6LuckyColorShort,
        character: no6destinychar,
        gemStone: no6GemStone,
        luckyDates: no6LuckyDates,
      ));
    } else if (destiny == 7) {
      dCardsList.add(const DCard(
        no: '7',
        no1destinycharh: no7destinychar,
        no1destinyfutureh: no7destinyfuture,
        no1destinylifepartnerh: no7destinylifepartner,
        color: no7LuckyColorShort,
        character: no7destinychar,
        gemStone: no7GemStone,
        luckyDates: no7LuckyDates,
      ));
    } else if (destiny == 8) {
      dCardsList.add(const DCard(
        no: '8',
        no1destinycharh: no8destinychar,
        no1destinyfutureh: no8destinyfuture,
        no1destinylifepartnerh: no8destinylifepartner,
        color: no8LuckyColorShort,
        character: no8destinychar,
        gemStone: no8GemStone,
        luckyDates: no8LuckyDates,
      ));
    } else if (destiny == 9) {
      dCardsList.add(const DCard(
        no: '9',
        no1destinycharh: no9destinychar,
        no1destinyfutureh: no9destinyfuture,
        no1destinylifepartnerh: no9destinylifepartner,
        color: no9LuckyColorShort,
        character: no9destinychar,
        gemStone: no9GemStone,
        luckyDates: no9LuckyDates,
      ));
    }
    Provider.of<ShowContainer>(context, listen: false).setShowContainer(true);
  }

  @override
  Widget build(BuildContext context) {
    bool showContainer = Provider.of<ShowContainer>(context).showContainer;
    return PopScope(
      onPopInvoked: (didPop) {
        Provider.of<ShowContainer>(context, listen: false)
            .setShowContainer(false);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 242, 222),
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
                    background: const Color.fromARGB(255, 255, 242, 222),
                    gradient1: const Color.fromARGB(255, 192, 40, 114),
                    gradient2: const Color.fromARGB(255, 255, 154, 111),
                    extra: appbar(
                        "assets/man_4202843.png", "Bring Your Luck", context,
                        () {
                      // log(showContainer.toString());
                      Provider.of<ShowContainer>(context, listen: false)
                          .setShowContainer(false);
                      Navigator.pop(context);
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color.fromRGBO(195, 45, 114, 1))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Center(
                                child: Text(
                                  "Enter Your Date Of Birth",
                                  style: GoogleFonts.poppins(
                                      fontSize: 23,
                                      color: const Color.fromRGBO(71, 1, 35, 1),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 90,
                                  child: TextField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2)
                                    ],
                                    controller: d,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        filled: true,
                                        fillColor: const Color.fromRGBO(
                                            232, 232, 232, 1),
                                        hintText: "DD",
                                        contentPadding: const EdgeInsets.only(
                                            left: 35, top: 5)),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 90,
                                  child: TextField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2)
                                    ],
                                    keyboardType: TextInputType.number,
                                    controller: m,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        filled: true,
                                        fillColor: const Color.fromRGBO(
                                            232, 232, 232, 1),
                                        hintText: "MM",
                                        contentPadding: const EdgeInsets.only(
                                            left: 28, top: 5)),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 90,
                                  child: TextField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(4)
                                    ],
                                    keyboardType: TextInputType.number,
                                    controller: y,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        filled: true,
                                        hintText: "YY",
                                        fillColor: const Color.fromRGBO(
                                            232, 232, 232, 1),
                                        contentPadding: const EdgeInsets.only(
                                            left: 35, top: 5)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(255, 102, 36, 1)),
                                onPressed: () {
                                  if (d.text.isEmpty ||
                                      m.text.isEmpty ||
                                      y.text.isEmpty) {
                                    const snackBar = SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text(
                                          'Please enter all the fields...'),
                                      backgroundColor:
                                          Color.fromARGB(255, 229, 74, 74),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    return;
                                  } else {
                                    validity();
                                    // if (showContainer) {
                                    //   WidgetsBinding.instance
                                    //       .addPostFrameCallback((_) {
                                    //     Scrollable.ensureVisible(context);
                                    //   });
                                    //   log("Length  : ${pCardsList.length.toString()}");
                                    // }
                                  }
                                },
                                child: Text(
                                  "check now",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  showContainer
                      ? Column(
                          children: [
                            Column(
                              children: pCardsList,
                            ),
                            const SizedBox(height: 10),
                            Column(
                              children: dCardsList,
                            ),
                          ],
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.055,
                              right: MediaQuery.of(context).size.width * 0.05,
                              top: MediaQuery.of(context).size.height * 0.1),
                          child: Column(
                            children: [
                              AnimatedTextKit(
                                isRepeatingAnimation: true,
                                repeatForever: true,
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    "Enter date of birth and see and the magic ✨ ",
                                    textStyle: GoogleFonts.badScript(
                                        fontSize: 24, color: Colors.black54),
                                    speed: const Duration(milliseconds: 80),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
