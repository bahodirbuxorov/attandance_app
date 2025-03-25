// ignore_for_file: deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:vision/core/widgets/shimmer_loader.dart';

class WeeklyBarChart extends StatelessWidget {
  final bool isLoading;
  const WeeklyBarChart({super.key, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final data = [8.0, 7.5, 0.0, 9.0, 8.2, 6.0, 7.0];
    final labels = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];

    return Animate(
      effects: const [FadeEffect(), SlideEffect(begin: Offset(0, 0.05))],
      child: Container(
        height: 260,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF1E1E2E), const Color(0xFF2C2C3A)]
                : [Colors.blue.shade50, Colors.blue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.blue.withOpacity(0.1),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "weekly_attendance".tr(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // If loading, show shimmer
            if (isLoading)
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(7, (index) {
                    final barHeight = [60.0, 70.0, 40.0, 80.0, 75.0, 50.0, 65.0][index];
                    return ShimmerLoader(
                      height: barHeight,
                      width: 14,
                      borderRadius: BorderRadius.circular(6),
                    );
                  }),
                ),
              )

            // Else show chart
            else
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 10,
                    gridData: FlGridData(show: false),
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipRoundedRadius: 12,
                        tooltipPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        tooltipMargin: 8,
                        tooltipBorder: BorderSide.none,
                        getTooltipColor: (group) =>
                        isDark ? Colors.grey.shade800 : Colors.blueAccent,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final day = labels[group.x];
                          return BarTooltipItem(
                            "${day.tr()}: ${rod.toY.toStringAsFixed(1)} soat",
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) => Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              labels[value.toInt()].tr(),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? Colors.white70
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(data.length, (index) {
                      final value = data[index];
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: value,
                            width: 18,
                            borderRadius: BorderRadius.circular(8),
                            rodStackItems: [],
                            color: value == 0
                                ? (isDark
                                ? Colors.red.shade900.withOpacity(0.3)
                                : Colors.red.withOpacity(0.2))
                                : null,
                            gradient: value != 0
                                ? LinearGradient(
                              colors: [
                                Colors.green.shade400,
                                Colors.lightGreen.shade200,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            )
                                : null,
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
