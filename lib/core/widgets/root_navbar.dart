import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:easy_localization/easy_localization.dart';

// Ekranlar (yo'lingizga qarab import qiling)
import '../../features/admin/presentation/pages/admin_dashboard_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/attandance/presentation/attendance_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

class RootNavbar extends StatefulWidget {
  const RootNavbar({super.key});

  @override
  State<RootNavbar> createState() => _RootNavbarState();
}

class _RootNavbarState extends State<RootNavbar> {
  int _currentIndex = 0;


  bool isAdmin = true;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomePage(),
      const AttendancePage(),
      const ProfilePage(),
      if (isAdmin) const AdminDashboardPage(), // ✅ Admin page
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
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
          if (isAdmin)
            BottomNavigationBarItem(
              icon: const Icon(Icons.dashboard_customize_outlined),
              activeIcon: const Icon(Icons.dashboard_customize),
              label: 'Admin',
            ),
        ],
      ),
    );
  }
}
