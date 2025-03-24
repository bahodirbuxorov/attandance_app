import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vision/core/theme/colors.dart';

class AttendanceSummaryCard extends StatefulWidget {
  const AttendanceSummaryCard({super.key});

  @override
  State<AttendanceSummaryCard> createState() => _AttendanceSummaryCardState();
}

class _AttendanceSummaryCardState extends State<AttendanceSummaryCard> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final int totalDays = 24;
    final int present = 20;
    final int late = 2;
    final int absent = totalDays - present - late;

    List<PieChartSectionData> showingSections() {
      return List.generate(3, (i) {
        final isTouched = i == touchedIndex;
        final double radius = isTouched ? 60 : 45;
        switch (i) {
          case 0:
            return PieChartSectionData(
              value: present.toDouble(),
              color: AppColors.green,
              title: isTouched ? 'Kelgan: $present' : '$present',
              radius: radius,
              titleStyle: const TextStyle(color: Colors.white),
            );
          case 1:
            return PieChartSectionData(
              value: late.toDouble(),
              color: AppColors.orange,
              title: isTouched ? 'Kech: $late' : '$late',
              radius: radius,
              titleStyle: const TextStyle(color: Colors.white),
            );
          case 2:
            return PieChartSectionData(
              value: absent.toDouble(),
              color: AppColors.red,
              title: isTouched ? 'Kelmagan: $absent' : '$absent',
              radius: radius,
              titleStyle: const TextStyle(color: Colors.white),
            );
          default:
            return throw Error();
        }
      });
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.white, AppColors.grey.withOpacity(0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            "Davomat statistikasi",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 1.3,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (event, response) {
                    setState(() {
                      touchedIndex = response?.touchedSection?.touchedSectionIndex ?? -1;
                    });
                  },
                ),
                sectionsSpace: 4,
                centerSpaceRadius: 40,
                sections: showingSections(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _LegendDot(color: AppColors.green, label: 'Kelgan'),
              _LegendDot(color: AppColors.orange, label: 'Kech qolgan'),
              _LegendDot(color: AppColors.red, label: 'Kelmagan'),
            ],
          )
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
