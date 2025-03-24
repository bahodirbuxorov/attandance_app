// 📁 lib/features/profile/presentation/settings_page.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sozlamalar"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SettingsGroupTitle(title: "Ilova sozlamalari"),

          const _SettingsTile(
            icon: IconlyLight.notification,
            title: "Bildirishnomalar",
            value: "Yoqilgan",
          ),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Tungi rejim"),
            secondary: const Icon(IconlyLight.scan),
            value: isDarkMode,
            onChanged: (value) => ref.read(themeProvider.notifier).toggleTheme(),
          ),

          const Gap(24),

          const _SettingsGroupTitle(title: "Hisob"),
          const _SettingsTile(
            icon: IconlyLight.more_circle,
            title: "Tilingiz",
            value: "O'zbek tili",
          ),
          const _SettingsTile(
            icon: IconlyLight.shield_done,
            title: "Maxfiylik siyosati",
          ),
          const _SettingsTile(
            icon: IconlyLight.info_square,
            title: "Yordam",
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final String? value;
  final IconData? icon;

  const _SettingsTile({required this.title, this.value, this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: icon != null ? Icon(icon) : null,
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null)
            Text(value!, style: TextStyle(color: Theme.of(context).hintColor)),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
      onTap: () {},
    );
  }
}

class _SettingsGroupTitle extends StatelessWidget {
  final String title;

  const _SettingsGroupTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).hintColor,
        ),
      ),
    );
  }
}