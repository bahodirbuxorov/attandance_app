import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class AdminAttendanceHeatmap extends StatelessWidget {
  final List<DayAttendance> data;

  const AdminAttendanceHeatmap({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final maxValue = data.map((e) => e.count).fold<int>(0, (prev, el) => el > prev ? el : prev);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Oy bo‘yicha davomat (heatmap)",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: data.map((day) {
              final intensity = day.count / maxValue;
              final color = Color.lerp(Colors.grey[200], Colors.blue, intensity)!;

              return Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    color: intensity > 0.6 ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ).animate().fade(duration: 600.ms).slideY(),
        ],
      ),
    );
  }
}

class DayAttendance {
  final int day;
  final int count;

  DayAttendance({required this.day, required this.count});
}
