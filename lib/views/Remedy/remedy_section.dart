import 'dart:developer';
import 'package:cosmic_numeriics/model/task_model.dart';
import 'package:cosmic_numeriics/model/user_model.dart';
import 'package:cosmic_numeriics/services/firebase_service/auth_services.dart';
import 'package:cosmic_numeriics/services/sharedPrefarence/shared_services.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';

import 'package:cosmic_numeriics/widget/reusable_widget/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';

CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

class RemedySection extends StatefulWidget {
  const RemedySection({Key? key}) : super(key: key);

  @override
  _RemedySectionState createState() => _RemedySectionState();
}

class _RemedySectionState extends State<RemedySection> {
  @override
  void initState() {
    super.initState();
    getCompletedTaskInCalender();
  }

  void getCompletedTaskInCalender() {
    var completedTaskList = SharedServices.getUserData().completedTask;
    if (completedTaskList != null) {
      for (var i = 0; i < completedTaskList.length; i++) {
        completedDays.add(DateFormat("yyyy-MM-dd").format(
            DateTime.fromMillisecondsSinceEpoch(
                completedTaskList[i].completedAt!)));
      }
      log(completedDays.length.toString());
    }
  }

//..............................................................................................................................
// Get Streak count
  int getStreakCount() {
    int finalStreakCount = 0;
    if (SharedServices.getUserData().completedTask!.isEmpty) {
      return 0;
    } else {
      if (SharedServices.getUserData().completedTask?.last.createdAt ==
          DateTime.now().day) {
        finalStreakCount = 1;
      }
      if (isSameDay(
              DateTime.fromMillisecondsSinceEpoch(SharedServices.getUserData()
                  .completedTask!
                  .last
                  .completedAt!),
              DateTime.now()) ||
          isSameDay(
              DateTime.fromMillisecondsSinceEpoch(SharedServices.getUserData()
                  .completedTask!
                  .last
                  .completedAt!),
              DateTime.now().subtract(Duration(days: 1)))) {
        for (var i = 0;
            i < SharedServices.getUserData().completedTask!.length - 1;
            i++) {
          final difference = DateTime.fromMillisecondsSinceEpoch(
                  SharedServices.getUserData()
                      .completedTask![i + 1]
                      .completedAt!)
              .difference(DateTime.fromMillisecondsSinceEpoch(
                  SharedServices.getUserData().completedTask![i].completedAt!))
              .inDays;

          // completedTasksDates
          //     .add(SharedServices.getUserData().completedTask![i].completedAt!);

          if (difference != 1) {
            finalStreakCount = 0;
            log("date :${DateTime.fromMillisecondsSinceEpoch(SharedServices.getUserData().completedTask![i].completedAt!)} ");
            log("finalStreakCount 1:  ${finalStreakCount}");
          } else if (difference == 1) {
            finalStreakCount++;
            log("date 2:${DateTime.fromMillisecondsSinceEpoch(SharedServices.getUserData().completedTask![i].completedAt!)} ");

            log("finalStreakCount 2:  ${finalStreakCount}");
          }
        }
      }
      //   log("finalStreakCount :  ${finalStreakCount}");
      return finalStreakCount;
    }
  }
//..............................................................................................................................

  int streakCount = 0;
  List completedDays = [];
  DateTime? lastCompletedDay;
  DateTime selectedDay = DateTime.now();
  bool isCompleteButtonActive = false;
  bool isCongratulationVisible = false;

  bool isSameDay(DateTime day1, DateTime day2) {
    return day1.year == day2.year &&
        day1.month == day2.month &&
        day1.day == day2.day;
  }

  Map<DateTime, String> displayedTasks = {};

  @override
  Widget build(BuildContext context) {
    bool isToday = isSameDay(selectedDay, DateTime.now());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 242, 222),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecorativeAppBar(
                  barHeight: MediaQuery.of(context).size.height * 0.21,
                  barPad: MediaQuery.of(context).size.height * 0.16,
                  radii: 30,
                  background: const Color.fromARGB(255, 255, 242, 222),
                  gradient1: const Color.fromARGB(255, 192, 40, 114),
                  gradient2: const Color.fromARGB(255, 255, 154, 111),
                  extra: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.07,
                              left: MediaQuery.of(context).size.height * 0.03),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.07,
                              left: MediaQuery.of(context).size.height * 0.02),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: Image.asset("assets/remedy.png"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text("My Remedies",
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        letterSpacing: 1.0,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 10, bottom: 40),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 158, 18, 86),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            TableCalendar(
                              calendarFormat: _calendarFormat,
                              onFormatChanged: (format) {
                                setState(() {
                                  _calendarFormat = format;
                                });
                              },
                              eventLoader: (day) {
                                log(completedDays.toString());
                                log(DateFormat("yyyy-MM-dd").format(day));
                                if (completedDays.contains(
                                    DateFormat("yyyy-MM-dd").format(day))) {
                                  return [1];
                                } else {
                                  return [];
                                }
                              },
                              availableGestures: AvailableGestures.none,
                              calendarBuilders: CalendarBuilders(
                                markerBuilder: (context, day, events) {
                                  if (completedDays.contains(
                                      DateFormat("yyyy-MM-dd").format(day))) {
                                    return Container(
                                      width: 20,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                      ),
                                      child: const Text(
                                        '✓',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              calendarStyle: CalendarStyle(
                                todayDecoration: BoxDecoration(
                                  color: Colors.orange.shade300,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              headerStyle: HeaderStyle(
                                formatButtonTextStyle: const TextStyle()
                                    .copyWith(color: Colors.black),
                                formatButtonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.orange),
                                ),
                                leftChevronVisible: true,
                                rightChevronVisible: true,
                                titleTextStyle: const TextStyle(
                                    color: Colors.black, fontSize: 17),
                                headerMargin: const EdgeInsets.only(bottom: 8),
                              ),
                              focusedDay: selectedDay,
                              firstDay: DateTime(2000),
                              lastDay: DateTime(3000),
                              onDaySelected: (selectedDate, focusedDate) {
                                setState(() {
                                  selectedDay = selectedDate;
                                  isCompleteButtonActive =
                                      isSameDay(selectedDate, DateTime.now());
                                });
                              },
                            ),
                            if (isToday) const SizedBox(height: 20),
                            if (isToday)
                              //use strem builder here
                              FutureBuilder(
                                  future: AuthService.getTodaysRemedy(),
                                  builder: (context, snapshot) {
                                    return Card(
                                      margin: const EdgeInsets.all(8),
                                      child: ListTile(
                                        tileColor: const Color.fromARGB(
                                            255, 255, 220, 166),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: const BorderSide(
                                            color: Colors.orange,
                                            width: 2,
                                          ),
                                        ),
                                        title: const Text(
                                          'Remedy for Today:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 5),
                                            Text(
                                              snapshot.data?.remedyTitle
                                                      .toString() ??
                                                  "",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            if (SharedServices.getUserData()
                                                        .completedTask ==
                                                    null ||
                                                SharedServices.getUserData()
                                                    .completedTask!
                                                    .isEmpty)
                                              AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.blue
                                                          .withOpacity(0.3),
                                                      spreadRadius: 1,
                                                      blurRadius: 5,
                                                      offset:
                                                          const Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: MyButton(
                                                  message: "Complete Task ",
                                                  // onTap: () {
                                                  //   setState(() {
                                                  //     TaskResponseModel
                                                  //         taskModel =
                                                  //         TaskResponseModel();
                                                  //     taskModel =
                                                  //         snapshot.data!;
                                                  //     taskModel
                                                  //         .completedAt = DateTime
                                                  //             .now()
                                                  //         .millisecondsSinceEpoch;
                                                  //     AuthService
                                                  //             .submitTodaysRemedy(
                                                  //                 taskModel)
                                                  //         .whenComplete(() {
                                                  //       setState(() {
                                                  //         getCompletedTaskInCalender();
                                                  //       });
                                                  //     });
                                                  //   });
                                                  // },
                                                  onTap: () {
                                                    TaskResponseModel
                                                        taskModel =
                                                        TaskResponseModel();
                                                    taskModel = snapshot.data!;
                                                    taskModel
                                                        .completedAt = DateTime
                                                            .now()
                                                        .millisecondsSinceEpoch;
                                                    AuthService
                                                            .submitTodaysRemedy(
                                                                taskModel)
                                                        .whenComplete(() async {
                                                      UserModel user =
                                                          SharedServices
                                                              .getUserData();
                                                      user.completedTask!
                                                          .add(taskModel);
                                                      //   log("After Complete Task  : " + userModelToJson(user));
                                                      await SharedServices
                                                          .setUserData(user);
                                                      setState(() {
                                                        getCompletedTaskInCalender();
                                                      });
                                                    });
                                                  },
                                                ),
                                              ),
                                            //............................................

                                            if (SharedServices.getUserData()
                                                        .completedTask !=
                                                    null &&
                                                SharedServices.getUserData()
                                                    .completedTask!
                                                    .isNotEmpty &&
                                                DateFormat.yMd().format(DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            SharedServices
                                                                    .getUserData()
                                                                .completedTask!
                                                                .last
                                                                .completedAt!)) !=
                                                    DateFormat.yMd()
                                                        .format(DateTime.now()))
                                              AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.blue
                                                          .withOpacity(0.3),
                                                      spreadRadius: 1,
                                                      blurRadius: 5,
                                                      offset:
                                                          const Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: MyButton(
                                                  message: "Complete Task",
                                                  onTap: () {
                                                    TaskResponseModel
                                                        taskModel =
                                                        TaskResponseModel();
                                                    taskModel = snapshot.data!;
                                                    taskModel
                                                        .completedAt = DateTime
                                                            .now()
                                                        .millisecondsSinceEpoch;
                                                    AuthService
                                                            .submitTodaysRemedy(
                                                                taskModel)
                                                        .whenComplete(() async {
                                                      UserModel user =
                                                          SharedServices
                                                              .getUserData();
                                                      user.completedTask!
                                                          .add(taskModel);
                                                      //   log("After Complete Task  : " + userModelToJson(user));
                                                      await SharedServices
                                                          .setUserData(user);
                                                      setState(() {
                                                        getCompletedTaskInCalender();
                                                      });
                                                    });
                                                  },
                                                ),
                                              ),
                                            if (SharedServices.getUserData()
                                                        .completedTask !=
                                                    null &&
                                                SharedServices.getUserData()
                                                    .completedTask!
                                                    .isNotEmpty &&
                                                SharedServices.getUserData()
                                                        .completedTask!
                                                        .last
                                                        .completedAt !=
                                                    null &&
                                                DateFormat.yMd().format(DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            SharedServices
                                                                    .getUserData()
                                                                .completedTask!
                                                                .last
                                                                .completedAt!)) ==
                                                    DateFormat.yMd()
                                                        .format(DateTime.now()))
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const Text(
                                                  'Task Completed ✓',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            if (isToday) const SizedBox(height: 10),
                          ],
                        ),
                      ),

//..............................................................................................................................
// Streak Count print in the UI................

                      // Positioned(
                      //   left: 0,
                      //   right: 0,
                      //   top: -30,
                      //   child: Align(
                      //     alignment: Alignment.center,
                      //     child: InkWell(
                      //       onTap: () {
                      //         int a = getStreakCount();
                      //         log(a.toString());
                      //         //   AuthService.getTodaysRemedy();
                      //         // log(SharedServices.getUserData().dob.toString());
                      //       },
                      //       child: Container(
                      //         width: MediaQuery.of(context).size.width * 0.4,
                      //         height:
                      //             MediaQuery.of(context).size.height * 0.075,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(20),
                      //           gradient: const LinearGradient(
                      //             colors: [
                      //               Color.fromARGB(255, 192, 40, 114),
                      //               Color.fromARGB(255, 255, 154, 111),
                      //             ],
                      //           ),
                      //         ),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Text(
                      //               'Current Streak: ${getStreakCount()}',
                      //               style: const TextStyle(
                      //                   color: Colors.white, fontSize: 16),
                      //             ),
                      //             Text(
                      //               'Highest Streak: $streakCount',
                      //               style: const TextStyle(
                      //                   color: Colors.white, fontSize: 12),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

//..............................................................................................................................
                    ],
                  ),
                ),
              ],
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: isCongratulationVisible ? 1.0 : 0.0,
            child: Visibility(
              visible: isCongratulationVisible,
              child: Center(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(16),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 6, 190, 182),
                          Color.fromARGB(255, 66, 114, 192),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Stack(
                        children: [
                          Lottie.asset(
                              "assets/lottie/Animation - 1704570685490.json"),
                          Column(
                            children: [
                              const Text(
                                "Congratulations!",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "You have completed a 30-day streak!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isCongratulationVisible = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
