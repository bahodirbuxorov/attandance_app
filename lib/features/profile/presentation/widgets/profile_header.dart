import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/theme/colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 36,
          backgroundImage:
          NetworkImage('https://ui-avatars.com/api/?name=Akmal+Aliyev'),
        ),
        const Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Akmal Aliyev",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
            const Gap(4),
            Text("position".tr(), style: TextStyle(color: AppColors.textGrey)),
            Text("region".tr(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).hintColor,
                )),
          ],
        )
      ],
    );
  }
}
