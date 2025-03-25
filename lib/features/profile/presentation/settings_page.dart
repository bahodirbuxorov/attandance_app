// 📁 lib/features/profile/presentation/settings_page.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:vision/core/utils/shared_prefs.dart';
import '../../../../core/theme/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("settings".tr()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SettingsGroupTitle(title: "app_settings".tr()),

          _SettingsTile(
            icon: IconlyLight.notification,
            title: "notifications".tr(),
            value: "enabled".tr(),
          ),

          Card(
            color: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(
                "dark_mode".tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              secondary: Icon(
                IconlyLight.scan,
                color: Theme.of(context).iconTheme.color,
              ),
              value: isDarkMode,
              onChanged: (value) => ref.read(themeProvider.notifier).toggleTheme(),
              activeColor: Theme.of(context).colorScheme.primary,
              inactiveThumbColor: Theme.of(context).colorScheme.secondary,
            ),
          ),

          const Gap(24),
          _SettingsGroupTitle(title: "account".tr()),

          const _LanguagePickerTile(),

          _SettingsTile(
            icon: IconlyLight.shield_done,
            title: "privacy_policy".tr(),
          ),
          _SettingsTile(
            icon: IconlyLight.info_square,
            title: "help".tr(),
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
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
      ),
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

class _LanguagePickerTile extends StatelessWidget {
  const _LanguagePickerTile();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: const Icon(IconlyLight.more_circle),
        title: Text("language".tr()),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: context.supportedLocales.map((locale) {
          final isSelected = context.locale == locale;
          return ListTile(
            title: Text(_getLangName(locale)),
            trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
            onTap: () async {
              await context.setLocale(locale);
              await SharedPrefs.saveLocale(locale.languageCode, locale.countryCode);
            },
          );
        }).toList(),
      ),
    );
  }

  String _getLangName(Locale locale) {
    switch (locale.languageCode) {
      case 'uz':
        return locale.countryCode == 'CY' ? 'Ўзбекча (Кирилл)' : "O'zbekcha";
      case 'ru':
        return 'Русский';
      case 'en':
        return 'English';
      default:
        return locale.languageCode;
    }
  }
}