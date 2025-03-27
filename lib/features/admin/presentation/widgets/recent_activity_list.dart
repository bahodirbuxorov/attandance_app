import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class RecentActivityList extends StatelessWidget {
  final List<ActivityEntry> recentEntries;

  const RecentActivityList({super.key, required this.recentEntries});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1F1F1F) : Colors.white,
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
            "So‘nggi faoliyatlar",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),
          ListView.separated(
            itemCount: recentEntries.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final entry = recentEntries[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: entry.status == ActivityStatus.checkedIn
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  child: Icon(
                    entry.status == ActivityStatus.checkedIn
                        ? Icons.login
                        : Icons.logout,
                    color: entry.status == ActivityStatus.checkedIn
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                title: Text(entry.employeeName),
                subtitle: Text(entry.time),
                trailing: Text(
                  entry.status == ActivityStatus.checkedIn
                      ? "Kirdi"
                      : "Chiqdi",
                  style: TextStyle(
                    color: entry.status == ActivityStatus.checkedIn
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ).animate().fade(duration: 300.ms).slideX(begin: 0.2);
            },
          )
        ],
      ),
    );
  }
}

enum ActivityStatus { checkedIn, checkedOut }

class ActivityEntry {
  final String employeeName;
  final String time;
  final ActivityStatus status;

  ActivityEntry({
    required this.employeeName,
    required this.time,
    required this.status,
  });
}
