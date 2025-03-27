import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import '../../domain/models/performer_data.dart';

class WorstPerformersChart extends StatelessWidget {
  final List<PerformerData> worstPerformers;

  const WorstPerformersChart({super.key, required this.worstPerformers});

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
              : [const Color(0xFFFFEBEE), const Color(0xFFFFF9F9)],
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.red.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 6),
            )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Eng sust xodimlar",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
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
                        if (index < worstPerformers.length) {
                          return Transform.rotate(
                            angle: -0.5,
                            child: Text(
                              worstPerformers[index].name,
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
                barGroups: worstPerformers.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: data.attendancePercent.toDouble(),
                        color: Colors.redAccent,
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

