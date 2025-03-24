import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'title': 'Ishga kech kelganlik',
        'subtitle': '22-mart kuni 09:20 da ishga keldingiz.',
      },
      {
        'title': 'Chiqish belgilanmagan',
        'subtitle': 'Bugun chiqish vaqtingiz belgilanmagan.',
      },
      {
        'title': 'Yangi e’lon',
        'subtitle': 'Yangi kompaniya siyosati bilan tanishing.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bildirishnomalar"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return ListTile(
            leading: const Icon(IconlyLight.notification),
            title: Text(notif['title']!),
            subtitle: Text(notif['subtitle']!),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          );
        },
      ),
    );
  }
}
