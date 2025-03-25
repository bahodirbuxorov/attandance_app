import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/theme/colors.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _settingItem(
          context: context,
          icon: IconlyLight.profile,
          title: 'profile'.tr(),
          onTap: () {
            context.push('/edit-profile');
          },
        ),
        const Divider(height: 1),
        _settingItem(
          context: context,
          icon: IconlyLight.message,
          title: 'send_message'.tr(),
          onTap: () {
            context.push('/settings');
          },
        ),
        const Divider(height: 1),
        _settingItem(
          context: context,
          icon: IconlyLight.setting,
          title: 'settings'.tr(),
          onTap: () {
            context.push('/settings');
          },
        ),
        const Divider(height: 1),
        _settingItem(
          context: context,
          icon: IconlyLight.logout,
          title: 'logout'.tr(),
          onTap: () {},
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _settingItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.primaryGreen),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
      onTap: onTap,
    );
  }
}
