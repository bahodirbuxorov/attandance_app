import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminGoalProgress extends StatelessWidget {
  const AdminGoalProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('admin_goal'.tr(), style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            LinearPercentIndicator(
              lineHeight: 14,
              percent: 0.65,
              progressColor: Colors.deepPurple,
              backgroundColor: Colors.deepPurple.shade100,
              barRadius: const Radius.circular(16),
            ),
            const SizedBox(height: 8),
            Text("65% ${'completed'.tr()}",
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
