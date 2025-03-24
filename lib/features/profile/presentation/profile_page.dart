import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:vision/features/profile/presentation/widgets/info_card.dart';
import 'package:vision/features/profile/presentation/widgets/profile_header.dart';
import 'package:vision/features/profile/presentation/widgets/settings.dart';

import '../../../core/theme/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/logo/logo.png',
              height: 32,
            ),
            const SizedBox(width: 8),
            Text(
              "Mening hisobim",
              style: TextStyle(
                color: AppColors.appBarLogoText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            ProfileHeader(),
            Gap(24),
            ProfileInfoCard(),
            Gap(24),
            SettingsSection(),
          ],
        ),
      ),
    );
  }
}
