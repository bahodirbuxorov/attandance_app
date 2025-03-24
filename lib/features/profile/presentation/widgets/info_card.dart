import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            _infoTile("Telefon raqam", "+998 90 123 45 67"),
            const Divider(),
            _infoTile("Email", "akmal@company.uz"),
            const Divider(),
            _infoTile("Ish boshlagan sana", "12.01.2023"),
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