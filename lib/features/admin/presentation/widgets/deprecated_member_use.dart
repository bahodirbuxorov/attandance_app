import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';

// 1️⃣ Inactive Users Warning Card
class InactiveUsersCard extends StatelessWidget {
  final List<Map<String, String>> inactiveUsers = [
    {'name': 'Jasur Xudoyberdiyev', 'region': 'Toshkent'},
    {'name': 'Dilnoza Mamatqulova', 'region': 'Samarqand'},
    {'name': 'Alisher Nurmatov', 'region': 'Andijon'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Animate(
      effects: const [FadeEffect(), SlideEffect(begin: Offset(0, 0.05))],
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: isDark ? Colors.red.shade900 : Colors.red.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.warning, color: Colors.redAccent),
                  const SizedBox(width: 8),
                  Text(
                    'inactive_users'.tr(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Gap(12),
              ...inactiveUsers.map(
                    (user) => ListTile(
                  dense: true,
                  leading: const Icon(Icons.person_off, color: Colors.redAccent),
                  title: Text(user['name']!),
                  subtitle: Text(user['region']!),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
