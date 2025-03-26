import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class UserActivityChart extends StatelessWidget {
  const UserActivityChart({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final data = [5, 10, 7, 15, 8, 11, 13];
    final labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final total = data.reduce((a, b) => a + b);
    final avg = (total / data.length).toStringAsFixed(1);

    return Card(
      color: isDark ? const Color(0xFF1B1B2F) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            Text('weekly_checkins'.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                )),
            const SizedBox(height: 4),

            /// Description
            Text(
              "checkin_chart_subtitle".tr(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isDark ? Colors.white54 : Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            /// Chart
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipRoundedRadius: 10,
                      getTooltipColor: (group) => isDark ? Colors.black87 : Colors.white,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${labels[group.x]}: ${rod.toY.toInt()} check-ins',
                          TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },

                ),
                  ),
                  barGroups: List.generate(
                    data.length,
                        (i) => BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: data[i].toDouble(),
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(6),
                          width: 18,
                        ),
                      ],
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) => Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            labels[value.toInt()],
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${'total'.tr()}: $total",
                    style: Theme.of(context).textTheme.bodyMedium),
                Text("${'average'.tr()}: $avg/day",
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            )
          ],
        ),
      ),
    );
  }
}
