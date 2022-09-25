import 'package:aroundix_task/constants/global_variables.dart';
import 'package:aroundix_task/features/home/screens/all_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:aroundix_task/features/home/screens/profile_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWith = 42;
  double bottomBarBorderWith = 5;

  List<Widget> pages = [const AllProductScreen(), const ProfileScreen()];

  void _updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.secondaryColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: _updatePage,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWith,
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                      color: (_page == 0)
                          ? GlobalVariables.secondaryColor
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWith),
                )),
                child: const Icon(
                  Icons.home_outlined,
                  color: GlobalVariables.secondaryColor,
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWith,
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                      color: (_page == 1)
                          ? GlobalVariables.secondaryColor
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWith),
                )),
                child: const Icon(
                  Icons.person_outline_outlined,
                  color: GlobalVariables.secondaryColor,
                ),
              ),
              label: '')
        ],
      ),
    );
  }
}
