import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminFilterBar extends HookWidget {
  const AdminFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedRegion = useState<String?>('Toshkent');
    final selectedPeriod = useState<String>('today');

    final regions = [
      'Toshkent',
      'Samarqand',
      'Andijon',
      'Fargʻona',
      'Buxoro',
      'Namangan',
      'Navoiy',
      'Qashqadaryo',
      'Surxondaryo',
      'Xorazm',
      'Jizzax',
      'Sirdaryo',
    ];

    final periods = {
      'today': 'today'.tr(),
      'this_week': 'this_week'.tr(),
      'this_month': 'this_month'.tr(),
    };

    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Sarlavha
          Text(
            "Filterlar",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const Gap(12),

          /// 🔸 Wrap Filter UI
          Wrap(
            spacing: 16,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              /// 📍 Viloyat Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedRegion.value,
                    isDense: true,
                    borderRadius: BorderRadius.circular(12),
                    hint: Text('select_region'.tr()),
                    items: regions.map((region) {
                      return DropdownMenuItem(
                        value: region,
                        child: Text(region),
                      );
                    }).toList(),
                    onChanged: (value) => selectedRegion.value = value,
                  ),
                ),
              ),

              /// 🕒 Vaqt oralig‘i
              ...periods.entries.map((entry) {
                final selected = selectedPeriod.value == entry.key;
                return ChoiceChip(
                  label: Text(entry.value),
                  selected: selected,
                  onSelected: (_) => selectedPeriod.value = entry.key,
                  selectedColor: Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context).cardColor,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : Theme.of(context).textTheme.bodyMedium?.color,
                    fontWeight: FontWeight.w500,
                  ),
                  elevation: selected ? 4 : 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
