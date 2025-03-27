import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:iconly/iconly.dart';

// Sahifalar
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
    final isMobile = MediaQuery.of(context).size.width < 600;

    final List<Widget> screens = [
      const HomePage(),
      const AttendancePage(),
      const ProfilePage(),
      if (isAdmin) const AdminDashboardPage(),
    ];

    final List<BottomNavigationBarItem> bottomItems = [
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
        const BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_customize_outlined),
          activeIcon: Icon(Icons.dashboard_customize),
          label: 'Admin',
        ),
    ];

    final List<Widget> appBarNavItems = [
      _navItem('home'.tr(), 0),
      _navItem('attendance'.tr(), 1),
      _navItem('profile'.tr(), 2),
      if (isAdmin) _navItem('Admin', 3),
    ];

    return Scaffold(
      appBar: isMobile
          ? null
          : AppBar(
        title: Text([
          'home'.tr(),
          'attendance'.tr(),
          'profile'.tr(),
          'Admin',
        ][_currentIndex]),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          Row(children: appBarNavItems),
          const SizedBox(width: 16),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: screens[_currentIndex],
      ),
      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: bottomItems,
      )
          : null,
    );
  }

  Widget _navItem(String label, int index) {
    final bool selected = _currentIndex == index;
    return TextButton(
      onPressed: () => setState(() => _currentIndex = index),
      style: TextButton.styleFrom(
        foregroundColor: selected
            ? Theme.of(context).colorScheme.primary
            : Colors.grey,
        textStyle: TextStyle(
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      child: Text(label),
    );
  }
}
