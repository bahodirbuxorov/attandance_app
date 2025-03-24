import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vision/core/theme/colors.dart';

class MonthlyOverviewCard extends StatelessWidget {
  const MonthlyOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [FadeEffect(), SlideEffect(begin: Offset(0, 0.1))],
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mart 2025",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 8),
            const Text(
              "Jami ish kunlari: 24\nKelgan: 20 | Kech qolgan: 2 | Kelmagan: 2",
              style: TextStyle(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}