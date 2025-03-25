// ignore_for_file: deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:async';

import 'package:vision/core/theme/colors.dart';
import '../../../../core/widgets/shimmer_loader.dart';

class AttendanceSummaryCard extends StatefulWidget {
  const AttendanceSummaryCard({super.key});

  @override
  State<AttendanceSummaryCard> createState() => _AttendanceSummaryCardState();
}

class _AttendanceSummaryCardState extends State<AttendanceSummaryCard> with SingleTickerProviderStateMixin {
  int touchedIndex = -1;
  bool isLoading = true;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    // Simulate loading for shimmer
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });

    // Pulsating animation controller
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final int totalDays = 24;
    final int present = 20;
    final int late = 2;
    final int absent = totalDays - present - late;

    List<PieChartSectionData> showingSections() {
      return List.generate(3, (i) {
        final isTouched = i == touchedIndex;
        final double radius = isTouched ? 60 : 45;
        final fontSize = isTouched ? 16.0 : 14.0;
        switch (i) {
          case 0:
            return PieChartSectionData(
              value: present.toDouble(),
              color: AppColors.green,
              title: '$present',
              radius: radius,
              titleStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            );
          case 1:
            return PieChartSectionData(
              value: late.toDouble(),
              color: AppColors.orange,
              title: '$late',
              radius: radius,
              titleStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            );
          case 2:
            return PieChartSectionData(
              value: absent.toDouble(),
              color: AppColors.red,
              title: '$absent',
              radius: radius,
              titleStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            );
          default:
            return throw Error();
        }
      });
    }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 800),
      opacity: 1.0,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 600),
        offset: const Offset(0, 0.05),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF2E2E2E), const Color(0xFF1F1F1F)]
                  : [const Color(0xFFE3F2FD), const Color(0xFFFAFAFA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: Column(
            children: [
              Text(
                'attendance_summary'.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Shimmer if loading
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: isLoading
                    ? const ShimmerLoader(
                  height: 180,
                  width: 180,
                  shape: BoxShape.circle,
                  key: ValueKey('shimmer'),
                )
                    : Stack(
                  key: const ValueKey('piechart'),
                  alignment: Alignment.center,
                  children: [
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
                    ScaleTransition(
                      scale: Tween(begin: 1.0, end: 1.15).animate(
                        CurvedAnimation(
                          parent: _pulseController,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 10,
                children: [
                  _LegendDot(color: AppColors.green, label: 'present'.tr(), value: '$present'),
                  _LegendDot(color: AppColors.orange, label: 'late'.tr(), value: '$late'),
                  _LegendDot(color: AppColors.red, label: 'absent'.tr(), value: '$absent'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  final String value;

  const _LegendDot({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(width: 4),
        Text(
          "($value)",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).hintColor,
          ),
        ),
      ],
    );
  }
}
