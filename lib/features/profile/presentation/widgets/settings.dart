import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/colors.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _settingItem(
          icon: IconlyLight.profile,
          title: 'Profilni tahrirlash',
          onTap: () {

          },
        ),
        const Divider(height: 1),
        _settingItem(
          icon: IconlyLight.message,
          title: 'Xabar yuborish',
          onTap: () {
            context.push('/settings');
          },
        ),
        const Divider(height: 1),
        _settingItem(
          icon: IconlyLight.setting,
          title: 'Sozlamalar',
          onTap: () {
            context.push('/settings');
          },
        ),
        const Divider(height: 1),
        _settingItem(
          icon: IconlyLight.logout,
          title: 'Chiqish',
          onTap: () {

          },
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _settingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.primaryGreen),
      title: Text(title, style: TextStyle(color: color ?? Colors.black)),
      onTap: onTap,
    );
  }
}
