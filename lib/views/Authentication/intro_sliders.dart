import 'package:cosmic_numeriics/views/Authentication/new_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  List<ContentConfig> listContentConfig = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Start animation
    _animationController.forward();

    listContentConfig = [
      ContentConfig(
        title: "COSMIC NUMERATE",
        styleTitle: GoogleFonts.lora(
          fontSize: 24.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        description:
            "Allow miles wound place the leave had. To sitting subject no improve studied limited.",
        styleDescription: GoogleFonts.openSans(
          fontSize: 16.sp,
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
      ContentConfig(
        title: "EXPLORE NUMEROLOGY",
        styleTitle: GoogleFonts.lora(
          fontSize: 23.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        description:
            "Ye indulgence unreserved connection alteration appearance.",
        styleDescription: GoogleFonts.openSans(
          fontSize: 16.sp,
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
      ContentConfig(
        title: "DISCOVER YOURSELF",
        styleTitle: GoogleFonts.lora(
          fontSize: 24.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        description:
            "Out may few northward believing attempted. Yet timed being songs marry one defer men our.",
        styleDescription: GoogleFonts.openSans(
          fontSize: 16.sp,
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
    ];
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onDonePress() {
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const ChooseLoginSignupScreen()),
    // );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const NewLoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Animation using AnimatedContainer
        AnimatedContainer(
          duration: const Duration(seconds: 3),
          curve: Curves.easeInOut,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                //..............................................................
                // Colors.deepPurple.shade200,
                // Colors.deepPurple.shade800,
                //..............................................................
                Color.fromARGB(255, 192, 40, 114),
                Color.fromARGB(255, 255, 146, 100),
                Color.fromARGB(255, 255, 146, 100),
                Color.fromARGB(255, 151, 0, 73),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // Fade-in effect using AnimatedOpacity
        FadeTransition(
          opacity: _fadeAnimation,
          child: IntroSlider(
            key: UniqueKey(),
            listContentConfig: listContentConfig,
            onDonePress: onDonePress,
            indicatorConfig: const IndicatorConfig(
              sizeIndicator: 15,
              colorIndicator: Colors.white,
              // colorActiveIndicator: Colors.orangeAccent,
              colorActiveIndicator: Colors.orange,
            ),
            renderSkipBtn:
                const Text("Skip", style: TextStyle(color: Colors.white)),
            renderNextBtn: const Icon(Icons.navigate_next, color: Colors.white),
            renderDoneBtn: const Text("Get Started",
                style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
