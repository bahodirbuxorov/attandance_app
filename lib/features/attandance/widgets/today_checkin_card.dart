import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconly/iconly.dart';

class TodayCheckInCard extends StatelessWidget {
  const TodayCheckInCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [FadeEffect(), SlideEffect(begin: Offset(0, 0.05))],
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            const Icon(IconlyBold.time_circle, size: 40, color: Colors.green),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Bugungi holat",
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                const Text("Kelgan: 08:57\nChiqish: belgilanmagan"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
