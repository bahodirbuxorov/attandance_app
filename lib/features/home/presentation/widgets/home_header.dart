import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 32,
          backgroundImage:
          NetworkImage('https://ui-avatars.com/api/?name=Aliyev+Akmal'),
        ),
        const Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Aliyev Akmal',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
            const Gap(2),
            Text('Bosh hisobchi',
                style: Theme.of(context).textTheme.bodyMedium),
            Text('Toshkent viloyati',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).hintColor,
                )),
          ],
        )
      ],
    );
  }
}