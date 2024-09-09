import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movizone/features/Search/pages/searchscreen.dart';
import 'package:movizone/features/home/pages/home_screen.dart';

import '../../witshlist/witsh_list.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ValueNotifier<int> index = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: index,
      builder: (context, value, child) {
        return Scaffold(
          body: IndexedStack(
            index: value,
            children: [
              HomeScreen(),
              SearchScreen(),
              WitshListScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value){
            index.value =value;
            },
            currentIndex: value,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.red,
                  label: 'Home ',
                  icon: SvgPicture.asset(
                    'assets/home.svg',
                    colorFilter: ColorFilter.mode(
                        value == 0 ? Color(0xff12cdd9) : Colors.grey,
                        BlendMode.srcIn),
                  )),
              BottomNavigationBarItem(
                  label: 'Search',
                  icon: SvgPicture.asset(
                    'assets/search.svg',
                    colorFilter: ColorFilter.mode(
                        value == 1 ? Color(0xff12cdd9) : Colors.grey,
                        BlendMode.srcIn),
                  )),
              BottomNavigationBarItem(
                  label: 'Bookmark',
                  icon: SvgPicture.asset(
                    'assets/bookmark.svg',
                    colorFilter: ColorFilter.mode(
                        value == 2 ? Color(0xff12cdd9) : Colors.grey,
                        BlendMode.srcIn),
                  )),
            ],
          ),
        );
      },
    );
  }
}
