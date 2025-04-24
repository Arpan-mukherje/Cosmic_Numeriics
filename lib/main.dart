import 'dart:developer';
import 'package:cosmic_numeriics/constant/sharedpref.dart';
import 'package:cosmic_numeriics/firebase_options.dart';
import 'package:cosmic_numeriics/services/provider/chech_fundamentals_provider.dart';
import 'package:cosmic_numeriics/services/provider/community__file_post_caption_readmore_readless_provider.dart';
import 'package:cosmic_numeriics/services/provider/community_text_post_caption_readmore_readless_provider.dart';
import 'package:cosmic_numeriics/services/provider/internet_check_provider.dart';
import 'package:cosmic_numeriics/services/provider/list_provider.dart';
import 'package:cosmic_numeriics/services/provider/name_provider.dart';
import 'package:cosmic_numeriics/services/provider/name_suggest_controller.dart';
import 'package:cosmic_numeriics/services/provider/page_provider.dart';
import 'package:cosmic_numeriics/services/provider/show_container.dart';
import 'package:cosmic_numeriics/services/provider/show_text.dart';
import 'package:cosmic_numeriics/views/Authentication/login_check.dart';
import 'package:cosmic_numeriics/widget/reusable_widget/network_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    log("Firebase initialized successfully.");
  } catch (e) {
    log("Firebase initialization failed: $e");
  }
  preferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageChange()),
        ChangeNotifierProvider(create: (context) => ShowContainer()),
        ChangeNotifierProvider(create: (context) => NameChange()),
        ChangeNotifierProvider(create: (context) => ShowText()),
        ChangeNotifierProvider(create: (context) => ItemStateNotifier()),
        ChangeNotifierProvider(
            create: (context) => CommynityPostCaptionReadmoreReadless()),
        ChangeNotifierProvider(
            create: (context) => CommynityFilePostCaptionReadmoreReadless()),
        ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (context) => NameGeneratorController()),
        ChangeNotifierProvider(create: (context) => CheckFundamentalsProvider())
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'COSMIC NUMERIICS',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: Consumer<ConnectivityProvider>(
                builder: (context, provider, child) {
                  return StreamBuilder<bool>(
                    stream: provider.connectivityStream,
                    initialData: true,
                    builder: (context, snapshot) {
                      final isConnected = snapshot.data ?? false;
                      log('Connection status: $isConnected');
                      return isConnected
                          ? const LoginCheck()
                          : const NoConnectionWidget();
                    },
                  );
                },
              ),
            );
          }),
    );
  }
}
