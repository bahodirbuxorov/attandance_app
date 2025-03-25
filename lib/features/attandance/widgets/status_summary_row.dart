import 'package:flutter/material.dart';
import 'package:vision/core/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class StatusSummaryRow extends StatelessWidget {
  const StatusSummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        StatusBox(label: 'present', color: AppColors.green, count: 20),
        StatusBox(label: 'late', color: AppColors.orange, count: 2),
        StatusBox(label: 'absent', color: AppColors.red, count: 2),
      ],
    );
  }
}

class StatusBox extends StatelessWidget {
  final String label;
  final Color color;
  final int count;

  const StatusBox({super.key, required this.label, required this.color, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 22,
          child: Text(
            '$count',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(label.tr()), // ✅ Tarjima qilingan label
      ],
    );
  }
}
