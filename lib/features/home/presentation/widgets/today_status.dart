import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';
import 'package:easy_localization/easy_localization.dart';

class TodayStatusCard extends StatelessWidget {
  const TodayStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(IconlyLight.time_circle, size: 40, color: Colors.green),
            const Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('today_status'.tr(),
                    style: Theme.of(context).textTheme.titleMedium),
                const Gap(4),
                Text(
                  '${'checked_in_time'.tr()}\n${'not_checked_out'.tr()}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}