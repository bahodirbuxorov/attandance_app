import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/admin_attendance_heatmap.dart';
import '../widgets/admin_checkin_checkout_line_chart.dart';
import '../widgets/admin_filter_bar.dart';
import '../widgets/admin_today_summary_card.dart';
import '../widgets/attendance_pie_chart_branch.dart';
import '../widgets/branch_comparison_bar_chart.dart';
import '../widgets/recent_activity_list.dart';
import '../widgets/top_performers_chart.dart';
import '../widgets/worst_performers_chart.dart';
import '../../domain/models/performer_data.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AdminFilterBar(),

            const Gap(24),

            /// 💡 Summary Section
            SectionTitle(title: "Bugungi holat"),
            AdminTodaySummaryCard(
              total: 120,
              present: 100,
              late: 10,
              absent: 10,
            ),

            const Gap(32),

            /// 📊 Regional Attendance
            SectionTitle(title: "Toshkent viloyati statistikasi"),
            AttendancePieChartBranch(
              regionName: 'Toshkent',
              present: 100,
              late: 10,
              absent: 10,
            ),

            const Gap(32),

            /// 🏅 Performance Charts
            SectionTitle(title: "Intizom bo‘yicha eng faol xodimlar"),
            TopPerformersChart(
              topPerformers: [
                PerformerData("Ali", 98),
                PerformerData("Aziza", 95),
                PerformerData("Javohir", 93),
                PerformerData("Malika", 92),
                PerformerData("Bekzod", 90),
              ],
            ),

            const Gap(24),

            SectionTitle(title: "Intizom bo‘yicha sust xodimlar"),
            WorstPerformersChart(
              worstPerformers: [
                PerformerData("Akbar", 60),
                PerformerData("Lola", 62),
                PerformerData("Rustam", 64),
                PerformerData("Dilnoza", 66),
                PerformerData("Siroj", 68),
              ],
            ),

            const Gap(32),

            /// 🔁 Realtime check-in/out log
            SectionTitle(title: "So‘nggi check-in/out ro‘yxati"),
            RecentActivityList(
              recentEntries: [
                ActivityEntry(employeeName: "Ali", time: "09:05", status: ActivityStatus.checkedIn),
                ActivityEntry(employeeName: "Aziza", time: "09:15", status: ActivityStatus.checkedIn),
                ActivityEntry(employeeName: "Javohir", time: "12:30", status: ActivityStatus.checkedOut),
                ActivityEntry(employeeName: "Malika", time: "08:59", status: ActivityStatus.checkedIn),
                ActivityEntry(employeeName: "Bekzod", time: "10:45", status: ActivityStatus.checkedOut),
              ],
            ),

            const Gap(32),

            /// 📈 Weekly Trend
            SectionTitle(title: "Haftalik Check-in/Check-out trendi"),
            AdminCheckInOutLineChart(
              checkIns: [
                ChartPoint(day: "Du", count: 110),
                ChartPoint(day: "Se", count: 120),
                ChartPoint(day: "Ch", count: 105),
                ChartPoint(day: "Pa", count: 130),
                ChartPoint(day: "Ju", count: 140),
              ],
              checkOuts: [
                ChartPoint(day: "Du", count: 100),
                ChartPoint(day: "Se", count: 115),
                ChartPoint(day: "Ch", count: 90),
                ChartPoint(day: "Pa", count: 120),
                ChartPoint(day: "Ju", count: 135),
              ],
            ),

            const Gap(32),

            /// 🌍 Branch Comparison
            SectionTitle(title: "Filiallar bo‘yicha taqqoslash"),
            BranchComparisonBarChart(
              branches: [
                BranchData(name: "Toshkent", totalEmployees: 120, presentEmployees: 110, attendancePercent: 92),
                BranchData(name: "Andijon", totalEmployees: 90, presentEmployees: 80, attendancePercent: 89),
                BranchData(name: "Fargʻona", totalEmployees: 100, presentEmployees: 85, attendancePercent: 85),
              ],
            ),

            const Gap(32),

            /// 📆 Monthly Overview
            SectionTitle(title: "Oy bo‘yicha davomat xaritasi"),
            AdminAttendanceHeatmap(
              data: List.generate(30, (index) {
                return DayAttendance(day: index + 1, count: (10 + (index * 2) % 50));
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
