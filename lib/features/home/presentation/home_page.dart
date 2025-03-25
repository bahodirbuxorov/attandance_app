import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vision/features/home/presentation/widgets/attendance_summary.dart';
import 'package:vision/features/home/presentation/widgets/home_header.dart';
import 'package:vision/features/home/presentation/widgets/recent_attendance.dart';
import 'package:vision/features/home/presentation/widgets/today_status.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : AppColors.appBarBackground,
        title: Row(
          children: [
            Image.asset('assets/logo/logo.png', height: 32),
            const SizedBox(width: 8),
            Text(
              'Hamkor Lizing',
              style: TextStyle(
                color: isDarkMode ? Colors.white : AppColors.appBarLogoText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            color: isDarkMode ? Colors.white : AppColors.appBarLogoText,
            onPressed: () => context.push('/notifications'),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              HomeHeader(),
              Gap(20),
              TodayStatusCard(),
              Gap(20),
              AttendanceSummaryCard(),
              Gap(20),
              RecentAttendanceList(),
            ],
          ),
        ),
      ),
    );
  }
}