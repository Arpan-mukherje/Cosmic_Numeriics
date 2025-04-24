import 'package:cosmic_numeriics/constant/constants.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/appbar_widget.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../services/provider/list_provider.dart';

class AboutNumo extends StatefulWidget {
  const AboutNumo({Key? key}) : super(key: key);

  @override
  State<AboutNumo> createState() => _AboutNumoState();
}

// ignore: camel_case_types
class _AboutNumoState extends State<AboutNumo> {
  @override
  Widget build(BuildContext context) {
    // print("from root");
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 242, 222),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(400),
              child: DecorativeAppBar(
                barHeight: MediaQuery.of(context).size.height * 0.24,
                barPad: MediaQuery.of(context).size.height * 0.19,
                radii: 30,
                background: const Color.fromARGB(255, 255, 242, 222),
                gradient1: const Color.fromARGB(255, 192, 40, 114),
                gradient2: const Color.fromARGB(255, 255, 154, 111),
                extra: appbar(
                    "assets/man_4202843.png", "About Numerology", context, () {
                  Navigator.pop(context);
                }),
              ),
            ),
            body: Consumer<ItemStateNotifier>(
                builder: (context, stateNotifier, child) {
              List<String> titles = [
                "What is Numerology?",
                "What is Primary Number?",
                "What is Destiny Number?",
                "What is Name Number?",
                "Which one is better, a name or date of birth for numerology?",
                "Significance of Number 1",
                "Significance of Number 2",
                "Significance of Number 3",
                "Significance of Number 4",
                "Significance of Number 5",
                "Significance of Number 6",
                "Significance of Number 7",
                "Significance of Number 8",
                "Significance of Number 9",
              ];

              List<String> containt = [
                "Numerology is a tool to know about one's life path number. All numbers are somewhere connected with the planets as each number represents a particular planet. These numbers have a magical power, which we actually do not understand.",
                "In numerology, there are nine primary numbers: 1, 2, 3, 4, 5, 6, 7, 8, and 9, each with its unique meanings and characteristics. Let's delve into the significance of each number in the realm of numerology. ",
                "Destiny Numbers are also known as Expression Numbers or Name Numbers. They are considered an essential part of a numerology chart.   They can help people understand their interests, abilities, attitudes, and talents.  They can also help people understand their life's purpose and who they are destined to become.",
                "In name numerology, the numerical value of a person's name is calculated using the letters of their first and last name.Name numerology readings can help determine a person's: Personality, Motivation, Strengths and weaknesses, Life challenges, Life purpose. For example, in numerology, the number 9 indicates that someone is honest, expressive, and independent. They are also strong-minded and prepared to weather any rough patches in life. ",
                "Both are equally better:the name shows you the assistance and the identity the world accords you while the date is showing you the identify and mission accorded to you by the divine.From the name you will get the personality number,the soul urge number and the expression number.From the date of birth you get your talent number,attitude number and the life path number.All the numbers work towards a similar goal in, assisting you to ascend spirituality.In numerology numbers from the name get linked via what we refer as the bridge numbers.",
                no1Character,
                no2Character,
                no3Character,
                no4Character,
                no5Character,
                no6Character,
                no7Character,
                no8Character,
                no9Character
              ];
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.02,
                        left: MediaQuery.of(context).size.width * 0.056,
                        bottom: 10),
                    child: Text(
                      "Relevent Infromation about Numerology :",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: const Color.fromRGBO(71, 1, 35, 1)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 5,
                      right: MediaQuery.of(context).size.width * 0.02,
                      left: MediaQuery.of(context).size.width * 0.056,
                    ),
                    child: const Divider(
                      color: Color.fromRGBO(71, 1, 35, 1),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 140, 202, 252),
                                  borderRadius: BorderRadius.circular(10),
                                  //   boxShadow: Colors.grey,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    stateNotifier.toggleItemState(i);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 154, 111),
                                      borderRadius: BorderRadius.circular(10),
                                      // gradient: const LinearGradient(colors: [
                                      //   Color.fromARGB(255, 192, 40, 114),
                                      //   Color.fromARGB(255, 255, 154, 111),
                                      // ])
                                    ),
                                    child: ListTile(
                                      leading: const CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(255, 192, 40, 114),
                                        radius: 6,
                                      ),
                                      title: Text(
                                        titles[i],
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      trailing:
                                          // IconButton(
                                          //   onPressed: () {
                                          //     // print("from onpress");
                                          //     stateNotifier.toggleItemState(i);
                                          //   },
                                          //
                                          // ),
                                          stateNotifier.isPressList[i] &&
                                                  i < containt.length
                                              ? const Icon(
                                                  Icons.arrow_drop_up_outlined,
                                                  size: 50,
                                                  color: Color.fromARGB(
                                                      255, 192, 40, 114),
                                                )
                                              : const Icon(
                                                  Icons
                                                      .arrow_drop_down_outlined,
                                                  size: 50,
                                                  color: Color.fromARGB(
                                                      255, 192, 40, 114),
                                                ),
                                    ),
                                  ),
                                ),
                              ),
                              if (stateNotifier.isPressList[i])
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    containt[i],
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                      itemCount: titles.length,
                    ),
                  ),
                ],
              );
            })));
  }
}
