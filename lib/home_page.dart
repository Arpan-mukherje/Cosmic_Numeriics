import 'package:cosmic_numeriics/services/provider/page_provider.dart';
import 'package:cosmic_numeriics/views/home/home_section.dart';
import 'package:cosmic_numeriics/views/community/community_section.dart';
import 'package:cosmic_numeriics/views/My_account/my_account_screen.dart';
import 'package:cosmic_numeriics/views/Remedy/remedy_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 242, 222),
        body: Consumer<PageChange>(
          builder: (context, pageChange, child) {
            return IndexedStack(
              index: pageChange.ind,
              children: [
                const HomeSection(),
                const FeedSection(),
                const RemedySection(),
                Myaccount(),
              ],
            );
          },
        ),
        bottomNavigationBar: Consumer<PageChange>(
          builder: (context, pageChange, child) {
            return Container(
              height: 60.h,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 158, 18, 86),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                currentIndex: pageChange.ind,
                onTap: (int index) {
                  pageChange.page(index);
                },
                selectedItemColor: Colors.orange,
                unselectedItemColor: Colors.white,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 30.sp,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.feed,
                      size: 28.sp,
                    ),
                    label: 'Community',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.tips_and_updates,
                      size: 30.sp,
                    ),
                    label: 'Remedy',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      size: 30.sp,
                    ),
                    label: 'My Account',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
