import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';

class RegionalCheckInChart extends StatefulWidget {
  const RegionalCheckInChart({super.key});

  @override
  State<RegionalCheckInChart> createState() => _RegionalCheckInChartState();
}

class _RegionalCheckInChartState extends State<RegionalCheckInChart> {
  DateTime selectedDate = DateTime.now();

  final List<Map<String, dynamic>> regionalData = [
    {'region': 'tashkent', 'count': 22},
    {'region': 'andijan', 'count': 18},
    {'region': 'samarkand', 'count': 25},
    {'region': 'bukhara', 'count': 14},
    {'region': 'namangan', 'count': 17},
    {'region': 'fergana', 'count': 20},
    {'region': 'navoiy', 'count': 13},
    {'region': 'xorazm', 'count': 19},
    {'region': 'surxondaryo', 'count': 21},
    {'region': 'qashqadaryo', 'count': 16},
    {'region': 'sirdaryo', 'count': 11},
    {'region': 'jizzakh', 'count': 15},
  ];

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Animate(
      effects: const [FadeEffect(), SlideEffect(begin: Offset(0, 0.05))],
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF2C2C3A), const Color(0xFF1E1E2E)]
                : [Colors.lightBlue.shade50, Colors.blue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'regional_checkins'.tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _pickDate(context),
                  icon: const Icon(Icons.calendar_today, size: 16),
                  label: Text(DateFormat('dd.MM.yyyy').format(selectedDate)),
                )
              ],
            ),
            const Gap(12),
            SizedBox(
              height: 260,
              child: BarChart(
                BarChartData(
                  maxY: 30,
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, _) {
                          final index = value.toInt();
                          if (index < regionalData.length) {
                            return Text(
                              regionalData[index]['region'].tr(),
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  barGroups: List.generate(
                    regionalData.length,
                        (i) => BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: regionalData[i]['count'].toDouble(),
                          width: 12,
                          gradient: LinearGradient(
                            colors: [Colors.indigoAccent, Colors.lightBlueAccent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
