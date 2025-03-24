import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

import '../../../core/theme/colors.dart';
import '../widgets/attendance_history_list.dart';
import '../widgets/monthly_overview_card.dart';
import '../widgets/status_summary_row.dart';
import '../widgets/today_checkin_card.dart';
import '../widgets/weekly_bar_chart.dart';
import '../widgets/attendance_filter_bar.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  String selectedFilter = 'Bu oy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/logo/logo.png',
              height: 32,
            ),
            const SizedBox(width: 8),
            Text(
              "Davomat",
              style: TextStyle(
                color: AppColors.appBarLogoText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              AttendanceFilterBar(
                selected: selectedFilter,
                onChanged: (value) => setState(() => selectedFilter = value),
              ),
              const Gap(16),
              const TodayCheckInCard(),
              const Gap(24),
              const MonthlyOverviewCard(),
              const Gap(24),
              const WeeklyBarChart(),
              const Gap(24),
              const StatusSummaryRow(),
              const Gap(24),
              const AttendanceHistoryList(),
            ],
          ),
        ),
      ),
    );
  }
}
