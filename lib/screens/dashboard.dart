import 'package:flutter/material.dart';
import 'package:urban_culture/screens/routine_screen.dart';
import 'package:urban_culture/screens/streaks_screen.dart';
import 'package:urban_culture/utils/urban_culture_colors.dart';
import 'package:urban_culture/utils/urban_culture_common.dart';
import 'package:urban_culture/utils/urban_culture_images.dart';
import 'package:urban_culture/utils/urban_culture_textstyles.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedTab = 0;

  List _pages = [
    RoutineScreen(),
    StreakScreen(),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        title: Text(
          _selectedTab == 0 ? 'Daily Skincare' : 'Streaks',
          style: UrbanCultureTextStyle.subtitleW700(
            color: UrbanCultureColors.urbanCulturTextColors.textTitleColor,
          ),
        ),
      ),
      body: Center(child: _pages[_selectedTab]),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // BottomNavigationBar
  Container _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
          color: UrbanCultureColors.scaffoldColor,
          border: BorderDirectional(
              top: BorderSide(
            color: UrbanCultureColors.containerColor,
          ))),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _changeTab(0);
                },
                child: Container(
                  color: Colors.transparent,
                  width: 65.2,
                  height: 54,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImgConstatnts.icRoutine,
                        height: 24,
                        width: 24,
                      ),
                      4.height,
                      Text(
                        "Routine",
                        style: UrbanCultureTextStyle.caption(
                            color: UrbanCultureColors.primaryColor),
                      )
                    ],
                  ),
                ),
              ),
              10.width,
              GestureDetector(
                onTap: () {
                  _changeTab(1);
                },
                child: Container(
                  color: Colors.transparent,
                  width: 65.2,
                  height: 54,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        ImgConstatnts.icStreak,
                        height: 24,
                        width: 24,
                      ),
                      4.height,
                      Text(
                        "Streaks",
                        style: UrbanCultureTextStyle.caption(
                            color: UrbanCultureColors.primaryColor),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
