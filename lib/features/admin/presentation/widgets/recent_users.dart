import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RecentUsersList extends StatelessWidget {
  const RecentUsersList({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      {
        'name': 'Ali Valiyev',
        'checkIn': '08:45',
        'checkOut': '17:30',
      },
      {
        'name': 'Dilnoza Karimova',
        'checkIn': '09:10',
        'checkOut': '17:20',
      },
      {
        'name': 'Jasur Mamatov',
        'checkIn': '08:58',
        'checkOut': '17:35',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'recent_users'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...users.map(
              (user) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 1,
            child: ListTile(
              leading: const CircleAvatar(
                radius: 24,
                child: Icon(Icons.person, size: 24),
              ),
              title: Text(user['name']!),
              subtitle: Text(
                '${'checked_in_at'.tr()}: ${user['checkIn']}   •   ${'checked_out_at'.tr()}: ${user['checkOut']}',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
