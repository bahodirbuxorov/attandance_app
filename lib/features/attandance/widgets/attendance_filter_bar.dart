import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AttendanceFilterBar extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const AttendanceFilterBar({super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final filters = [
      'today'.tr(),
      'this_week'.tr(),
      'this_month'.tr(),
      'all'.tr(),
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = filters[index];
          final isSelected = item == selected;

          return ChoiceChip(
            label: Text(item),
            selected: isSelected,
            onSelected: (_) => onChanged(item),
            selectedColor: Theme.of(context).colorScheme.primary,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
            ),
          );
        },
      ),
    );
  }
}
