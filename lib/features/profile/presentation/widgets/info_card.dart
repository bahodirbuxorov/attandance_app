import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _infoTile("phone".tr(), "+998 90 123 45 67"),
            const Divider(),
            _infoTile("email".tr(), "akmal@company.uz"),
            const Divider(),
            _infoTile("start_date".tr(), "12.01.2023"),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(value),
    );
  }
}
