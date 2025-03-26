import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminTipsCard extends StatelessWidget {
  const AdminTipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDark ? Colors.grey.shade900 : Colors.amber.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('tip_manage_users'.tr(), style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('tip_manage_users_desc'.tr(), style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
