import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cosmic_numeriics/services/provider/show_text.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/appbar_widget.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import '../../widget/home_widgets/name_card.dart';
import '../../constant/constants.dart';
import '../../services/provider/name_provider.dart';

class NameSection extends StatefulWidget {
  const NameSection({super.key});

  @override
  State<NameSection> createState() => _NameSectionState();
}

class _NameSectionState extends State<NameSection> {
  final TextEditingController name = TextEditingController();
  bool showContainer = false;
  bool showText = false;

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  void _clearState() {
    name.clear();
    Provider.of<NameChange>(context, listen: false).updateCardsList([]);
    Provider.of<NameChange>(context, listen: false).updateShowContainer(false);
  }

  // ignore: non_constant_identifier_names
  void NameCheck() {
    final Map<String, int> customValues = {
      'a': 1,
      'b': 2,
      'c': 3,
      'd': 4,
      'e': 5,
      'f': 8,
      'g': 3,
      'h': 5,
      'i': 1,
      'j': 1,
      'k': 2,
      'l': 3,
      'm': 4,
      'n': 5,
      'o': 7,
      'p': 8,
      'q': 1,
      'r': 2,
      's': 3,
      't': 4,
      'u': 6,
      'v': 6,
      'w': 6,
      'x': 5,
      'y': 1,
      'z': 7,
    };

    final String inputName = name.text.toLowerCase();
    int sum = inputName.codeUnits.fold(
      0,
      (int acc, int codeUnit) {
        final String character = String.fromCharCode(codeUnit);
        if (customValues.containsKey(character)) {
          return acc + customValues[character]!;
        }
        return acc;
      },
    );

    while (sum > 9) {
      int tempSum = 0;
      while (sum > 0) {
        tempSum += sum % 10;
        sum ~/= 10;
      }
      sum = tempSum;
    }

    if (sum == 4 || sum == 8) {
      Provider.of<ShowText>(context, listen: false).setShowEText(true);
    } else {
      Provider.of<ShowText>(context, listen: false).setShowEText(false);
    }

    final List<Widget> cardsList = [];

    if (sum >= 1 && sum <= 9) {
      if (sum == 1) {
        cardsList.add(NameCard(
          no: sum.toString(),
          lifePartner: no1lifePatnet,
          future: no1future,
          character: no1Character,
          gemStone: no1GemStone,
          luckyDates: no1LuckyDates,
          luckyColor: no1LuckyColorShort,
        ));
      } else if (sum == 2) {
        cardsList.add(NameCard(
          no: sum.toString(),
          lifePartner: no2lifePatnet,
          future: no2future,
          character: no2Character,
          gemStone: no2GemStone,
          luckyDates: no2LuckyDates,
          luckyColor: no2LuckyColorShort,
        ));
      } else if (sum == 3) {
        cardsList.add(NameCard(
          no: sum.toString(),
          lifePartner: no3lifePatnet,
          future: no3future,
          character: no3Character,
          gemStone: no3GemStone,
          luckyDates: no3LuckyDates,
          luckyColor: no3LuckyColorShort,
        ));
      } else if (sum == 4) {
        cardsList.add(NameCard(
          no: sum.toString(),
          lifePartner: no4lifePatnet,
          future: no4future,
          character: no4Character,
          gemStone: no4GemStone,
          luckyDates: no4LuckyDates,
          luckyColor: no4LuckyColorShort,
        ));
      } else if (sum == 5) {
        cardsList.add(NameCard(
          no: sum.toString(),
          lifePartner: no5lifePatnet,
          future: no5future,
          character: no5Character,
          gemStone: no5GemStone,
          luckyDates: no5LuckyDates,
          luckyColor: no5LuckyColorShort,
        ));
      } else if (sum == 6) {
        cardsList.add(NameCard(
          no: sum.toString(),
          lifePartner: no6lifePatnet,
          future: no6future,
          character: no6Character,
          gemStone: no6GemStone,
          luckyDates: no6LuckyDates,
          luckyColor: no6LuckyColorShort,
        ));
      } else if (sum == 7) {
        cardsList.add(NameCard(
          no: sum.toString(),
          lifePartner: no7lifePatnet,
          future: no7future,
          character: no7Character,
          gemStone: no7GemStone,
          luckyDates: no7LuckyDates,
          luckyColor: no7LuckyColorShort,
        ));
      } else if (sum == 8) {
        cardsList.add(NameCard(
          no: sum.toString(),
          lifePartner: no8lifePatnet,
          future: no8future,
          character: no8Character,
          gemStone: no8GemStone,
          luckyDates: no8LuckyDates,
          luckyColor: no8LuckyColorShort,
        ));
      } else if (sum == 9) {
        cardsList.add(NameCard(
          no: sum.toString(),
          lifePartner: no9lifePatnet,
          future: no9future,
          character: no9Character,
          gemStone: no9GemStone,
          luckyDates: no9LuckyDates,
          luckyColor: no9LuckyColorShort,
        ));
      }
    }

    final nameChange = Provider.of<NameChange>(context, listen: false);

    nameChange.updateCardsList(cardsList);
    nameChange.updateShowContainer(cardsList.isNotEmpty);
  }

  void validity() {
    if (name.text.contains("~") ||
        name.text.contains("!") ||
        name.text.contains("@") ||
        name.text.contains("#") ||
        name.text.contains('\$') ||
        name.text.contains("%") ||
        name.text.contains("^") ||
        name.text.contains("&") ||
        name.text.contains("*") ||
        name.text.contains("(") ||
        name.text.contains(")") ||
        name.text.contains("-") ||
        name.text.contains("+") ||
        name.text.contains("=") ||
        name.text.contains("_") ||
        name.text.contains("/") ||
        name.text.contains("|") ||
        name.text.contains("[") ||
        name.text.contains("]") ||
        name.text.contains("{") ||
        name.text.contains("}") ||
        name.text.contains(".") ||
        name.text.contains(",") ||
        name.text.contains(":") ||
        name.text.contains("?") ||
        name.text.contains("<") ||
        name.text.contains(">") ||
        name.text.contains(";") ||
        name.text.contains("'")) {
      const snackBar = SnackBar(
        content: Text('Letter should be between a-z or A-Z'),
        backgroundColor: Color.fromARGB(255, 229, 74, 74),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      NameCheck();
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameChange = Provider.of<NameChange>(context);
    final cardsList = nameChange.cardsList;
    final showContainer = nameChange.showContainer;

    return PopScope(
      onPopInvoked: (didPop) {
        Provider.of<NameChange>(context, listen: false).namec(false);

        _clearState();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 242, 222),
          body: SingleChildScrollView(
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
                      "assets/man_4202843.png", "Bring Your Luck", context, () {
                    _clearState();
                    Provider.of<NameChange>(context, listen: false)
                        .namec(false);
                    Navigator.pop(context);
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10, top: 5),
                  child: Container(
                    padding: const EdgeInsets.all(16),
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
                                "Enter Your Name",
                                style: GoogleFonts.poppins(
                                  fontSize: 23,
                                  color: const Color.fromRGBO(71, 1, 35, 1),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: SizedBox(
                              height: 40,
                              child: TextField(
                                controller: name,
                                decoration: const InputDecoration(
                                  hintText: "Full Name",
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(255, 102, 36, 1),
                              ),
                              onPressed: () {
                                validity();
                                if (true) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Scrollable.ensureVisible(context);
                                  });
                                }
                              },
                              child: Text(
                                "chech now",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
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
                        children: cardsList,
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.09,
                            right: MediaQuery.of(context).size.width * 0.05,
                            top: MediaQuery.of(context).size.height * 0.1),
                        child: Column(
                          children: [
                            AnimatedTextKit(
                              isRepeatingAnimation: true,
                              repeatForever: true,
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  "Enter your name and see and the magic ✨ ",
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
    );
  }
}
