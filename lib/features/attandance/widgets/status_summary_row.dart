import 'package:flutter/material.dart';
import 'package:vision/core/theme/colors.dart';

class StatusSummaryRow extends StatelessWidget {
  const StatusSummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        StatusBox(label: 'Kelgan', color: AppColors.green, count: 20),
        StatusBox(label: 'Kech', color: AppColors.orange, count: 2),
        StatusBox(label: 'Kelmagan', color: AppColors.red, count: 2),
      ],
    );
  }
}

class StatusBox extends StatelessWidget {
  final String label;
  final Color color;
  final int count;

  const StatusBox({required this.label, required this.color, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 22,
          child: Text(
            '$count',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 6),
        Text(label),
      ],
    );
  }
}
