import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class AttendancePieChartBranch extends StatelessWidget {
  final String regionName;
  final int present;
  final int late;
  final int absent;

  const AttendancePieChartBranch({
    super.key,
    required this.regionName,
    required this.present,
    required this.late,
    required this.absent,
  });

  @override
  Widget build(BuildContext context) {
    final total = present + late + absent;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF2E2E2E), const Color(0xFF1F1F1F)]
              : [const Color(0xFFF0F4FF), const Color(0xFFFFFFFF)],
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '$regionName uchun statistikasi',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),
          SizedBox(
            height: 220,
            child: PieChart(
              PieChartData(
                sectionsSpace: 4,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    value: present.toDouble(),
                    color: Colors.green,
                    title: '$present',
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    radius: 60,
                  ),
                  PieChartSectionData(
                    value: late.toDouble(),
                    color: Colors.orange,
                    title: '$late',
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    radius: 60,
                  ),
                  PieChartSectionData(
                    value: absent.toDouble(),
                    color: Colors.red,
                    title: '$absent',
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    radius: 60,
                  ),
                ],
              ),
            ),
          ).animate().fade(duration: 500.ms).slideY(),
          const Gap(20),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _legendDot(color: Colors.green, label: "Keldi", count: present),
              _legendDot(color: Colors.orange, label: "Kechikdi", count: late),
              _legendDot(color: Colors.red, label: "Kelmadi", count: absent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendDot({
    required Color color,
    required String label,
    required int count,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 6),
        Text(
          "$label: $count",
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
