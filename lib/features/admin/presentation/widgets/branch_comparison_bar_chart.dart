import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class BranchComparisonBarChart extends StatelessWidget {
  final List<BranchData> branches;

  const BranchComparisonBarChart({super.key, required this.branches});

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
              : [const Color(0xFFF1F5FF), Colors.white],
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            "Viloyatlar bo‘yicha bugungi davomat foizi",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const Gap(8),

          /// Description
          Text(
            "Quyidagi grafikda har bir viloyatdagi xodimlar bugun ishga kelganlik foizi ko‘rsatilgan. Foiz = (Keldi / Jami xodimlar) * 100",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).hintColor,
            ),
          ),

          const Gap(16),

          /// Bar chart
          SizedBox(
            height: 260,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, _) => Text('${value.toInt()}%'),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        final index = value.toInt();
                        if (index < branches.length) {
                          return Transform.rotate(
                            angle: -0.5,
                            child: Text(
                              branches[index].name,
                              style: const TextStyle(fontSize: 11),
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
                barGroups: branches.asMap().entries.map((entry) {
                  final index = entry.key;
                  final branch = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: branch.attendancePercent.toDouble(),
                        color: Colors.blueAccent,
                        width: 18,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ).animate().fade(duration: 600.ms).slideY(),

          const Gap(12),

          /// Mini Legend
          ...branches.map((branch) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 8, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text(
                  "${branch.name}: ${branch.presentEmployees}/${branch.totalEmployees} keldi — ${branch.attendancePercent}%",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class BranchData {
  final String name;
  final int totalEmployees;
  final int presentEmployees;
  final int attendancePercent;

  BranchData({
    required this.name,
    required this.totalEmployees,
    required this.presentEmployees,
    required this.attendancePercent,
  });
}
