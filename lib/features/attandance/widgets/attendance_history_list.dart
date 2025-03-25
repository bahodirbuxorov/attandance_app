import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:vision/core/widgets/shimmer_loader.dart';

class AttendanceHistoryList extends StatelessWidget {
  final bool isLoading;

  const AttendanceHistoryList({super.key, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> history = [
      {
        "date": "23.03.2025",
        "in": "08:57",
        "out": "17:32",
        "status": IconlyBold.tick_square,
        "color": Colors.green,
      },
      {
        "date": "22.03.2025",
        "in": "09:20",
        "out": "17:30",
        "status": IconlyBold.danger,
        "color": Colors.orange,
      },
      {
        "date": "21.03.2025",
        "in": "08:55",
        "out": "17:30",
        "status": IconlyBold.tick_square,
        "color": Colors.green,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "recent_attendance".tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap(12),

        // Loading shimmer
        if (isLoading)
          ...List.generate(
            3,
                (index) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const ShimmerLoader(height: 28, width: 28, shape: BoxShape.circle),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ShimmerLoader(height: 14, width: 100),
                        SizedBox(height: 6),
                        ShimmerLoader(height: 12, width: 180),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        else
          ...history.map(
                (entry) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [Colors.grey.shade900, Colors.grey.shade800]
                      : [Colors.grey.shade100, Colors.grey.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                leading: CircleAvatar(
                  backgroundColor: entry['color'].withOpacity(0.15),
                  radius: 22,
                  child: Icon(entry['status'], color: entry['color'], size: 22),
                ),
                title: Text(
                  entry['date'],
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  "${'checked_in_at'.tr()}: ${entry['in']}, ${'checked_out_at'.tr()}: ${entry['out']}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
