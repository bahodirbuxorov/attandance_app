import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../features/attandance/presentation/attendance_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

class RootNavbar extends StatefulWidget {
  const RootNavbar({super.key});

  @override
  State<RootNavbar> createState() => _RootNavbarState();
}

class _RootNavbarState extends State<RootNavbar> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomePage(),
    AttendancePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.home),
            activeIcon: const Icon(IconlyBold.home),
            label: 'home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.calendar),
            activeIcon: const Icon(IconlyBold.calendar),
            label: 'attendance'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.profile),
            activeIcon: const Icon(IconlyBold.profile),
            label: 'profile'.tr(),
          ),
        ],
      ),
    );
  }
}


/// Helper widget to rebuild RootNavbar with a new selected tab
class RootNavbarWithIndex extends StatefulWidget {
  final int index;
  const RootNavbarWithIndex({super.key, required this.index});

  @override
  State<RootNavbarWithIndex> createState() => _RootNavbarWithIndexState();
}

class _RootNavbarWithIndexState extends State<RootNavbarWithIndex> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RootNavbar(); // Or if needed: rebuild based on _currentIndex
  }
}
