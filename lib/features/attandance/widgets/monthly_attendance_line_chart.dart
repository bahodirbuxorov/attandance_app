// ignore_for_file: deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class MonthlyLineChartWithFilters extends StatefulWidget {
  const MonthlyLineChartWithFilters({super.key});

  @override
  State<MonthlyLineChartWithFilters> createState() => _MonthlyLineChartWithFiltersState();
}

class _MonthlyLineChartWithFiltersState extends State<MonthlyLineChartWithFilters> {
  int selectedDays = 30;

  final List<double> allData = List.generate(30, (i) => (6 + (i % 5) + (i % 3)).toDouble());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredData = allData.take(selectedDays).toList();
    final List<String> weekdays = ['Du', 'Se', 'Ch', 'Pa', 'Ju', 'Sh', 'Ya'];

    return Animate(
      effects: const [FadeEffect(), SlideEffect(begin: Offset(0, 0.1))],
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isDark
              ? const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : const LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black26 : Colors.blue.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? Colors.white10 : Colors.blue.shade100,
                  ),
                  child: Icon(Icons.show_chart, color: isDark ? Colors.white : Colors.blueAccent),
                ),
                const SizedBox(width: 12),
                Text(
                  "monthly_attendance_chart".tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [7, 15, 30].map((e) {
                final isSelected = selectedDays == e;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    label: Text("$e ${"days".tr()}"),
                    selected: isSelected,
                    onSelected: (_) => setState(() => selectedDays = e),
                    selectedColor: Colors.deepPurple,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black),
                    ),
                    backgroundColor: isDark ? Colors.black12 : Colors.grey.shade300,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (spots) => isDark ? Colors.black87 : Colors.white,

                      tooltipRoundedRadius: 10,
                      getTooltipItems: (spots) {
                        return spots.map((spot) {
                          return LineTooltipItem(
                            '${spot.y.toStringAsFixed(1)} soat',
                            TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, _) {
                          int index = value.toInt();
                          if (index >= filteredData.length) return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              weekdays[index % 7],
                              style: TextStyle(
                                fontSize: 10,
                                color: isDark ? Colors.white60 : Colors.grey.shade700,
                              ),
                            ),
                          );
                        },
                        interval: (selectedDays / 6).floorToDouble(),
                      ),
                    ),
                    leftTitles: AxisTitles(
                      axisNameWidget: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          "soat",
                          style: TextStyle(
                            color: isDark ? Colors.white70 : Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      axisNameSize: 24,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, _) => Text(
                          value.toStringAsFixed(0),
                          style: TextStyle(
                            color: isDark ? Colors.white60 : Colors.grey.shade700,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: (filteredData.length - 1).toDouble(),
                  minY: 6,
                  maxY: 12,
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: Colors.deepPurpleAccent,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      spots: List.generate(
                        filteredData.length,
                            (i) => FlSpot(i.toDouble(), filteredData[i]),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurpleAccent.withOpacity(0.3),
                            Colors.deepPurple.withOpacity(0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
