import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  const LoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'login'.tr(),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: 0.2);
  }
}