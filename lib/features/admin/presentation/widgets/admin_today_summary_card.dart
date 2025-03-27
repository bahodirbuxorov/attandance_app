import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';

class AdminTodaySummaryCard extends StatelessWidget {
  final int total;
  final int present;
  final int late;
  final int absent;

  const AdminTodaySummaryCard({
    super.key,
    required this.total,
    required this.present,
    required this.late,
    required this.absent,
  });

  @override
  Widget build(BuildContext context) {
    final percentPresent = (present / total * 100).toStringAsFixed(0);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF2E2E2E), const Color(0xFF1F1F1F)]
              : [const Color(0xFFE3F2FD), const Color(0xFFF5F5F5)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 6),
            )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bugungi holat",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(12),
          Row(
            children: [
              _buildStatus(
                context,
                icon: IconlyBold.show,
                label: "Keldi",
                count: present,
                color: Colors.green,
              ),
              const Spacer(),
              _buildStatus(
                context,
                icon: IconlyBold.time_circle,
                label: "Kechikdi",
                count: late,
                color: Colors.orange,
              ),
              const Spacer(),
              _buildStatus(
                context,
                icon: IconlyBold.close_square,
                label: "Kelmadi",
                count: absent,
                color: Colors.red,
              ),
            ],
          ),
          const Gap(16),
          Text(
            "Jami xodimlar: $total | Keldi: $percentPresent%",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).hintColor,
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 500.ms).slideY();
  }

  Widget _buildStatus(
      BuildContext context, {
        required IconData icon,
        required String label,
        required int count,
        required Color color,
      }) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        const Gap(6),
        Text(
          '$count',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
