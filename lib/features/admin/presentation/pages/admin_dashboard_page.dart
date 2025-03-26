import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconly/iconly.dart';

import '../widgets/admin_goal_progress.dart';
import '../widgets/admin_tips_card.dart';
import '../widgets/deprecated_member_use.dart';
import '../widgets/recent_users.dart';
import '../widgets/user_activity.dart';
import '../widgets/user_stat_cards.dart';
import '../widgets/weekly_chekin.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('admin_dashboard'.tr()),
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ✅ User Stats Row
              Row(
                children: [
                  Expanded(
                    child: UserStatCard(
                      title: 'total_users',
                      count: 108,
                      icon: IconlyLight.user_1,
                      color: Colors.indigo,
                    ),
                  ),
                  const Gap(12),
                  const Expanded(
                    child: UserStatCard(
                      title: 'active_users',
                      count: 95,
                      icon: IconlyLight.tick_square,
                      color: Colors.green,
                    ),
                  ),
                  const Gap(12),
                  const Expanded(
                    child: UserStatCard(
                      title: 'blocked_users',
                      count: 13,
                      icon: IconlyLight.danger,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),

              const Gap(24),

              /// 🧯 Inactive Users Warning
              InactiveUsersCard(),

              const Gap(24),

              /// 📊 Weekly Check-in Heatmap
              RegionalCheckInChart(),

              const Gap(24),

              /// 📈 User Activity Chart
              const UserActivityChart(),

              const Gap(24),

              /// 📋 Recent Users List
              const RecentUsersList(),

              const Gap(24),

              /// 🎯 Admin Goal Progress
              const AdminGoalProgress(),

              const Gap(24),

              /// 💡 Tips or Notes
              const AdminTipsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
