import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import '../../domain/models/performer_data.dart';

class TopPerformersChart extends StatelessWidget {
  final List<PerformerData> topPerformers;

  const TopPerformersChart({super.key, required this.topPerformers});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF2E2E2E), const Color(0xFF1F1F1F)]
              : [const Color(0xFFF1F5FE), const Color(0xFFFFFFFF)],
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 6),
            )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Eng intizomli xodimlar",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),
          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, _) =>
                          Text("${value.toInt()}%"),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        final index = value.toInt();
                        if (index < topPerformers.length) {
                          return Transform.rotate(
                            angle: -0.5,
                            child: Text(
                              topPerformers[index].name,
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                barGroups: topPerformers.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: data.attendancePercent.toDouble(),
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                        width: 18,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ).animate().fade(duration: 500.ms).slideY(),
        ],
      ),
    );
  }
}
