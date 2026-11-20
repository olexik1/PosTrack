import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

class FilterDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final Map<T?, String> options;
  final ValueChanged<T?> onChanged;

  const FilterDropdown({
    super.key,
    required this.label,
    this.value,
    required this.options,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.photoButton,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T?>(
              isExpanded: true,
              value: value,
              items: [
                for (final e in options.entries)
                  DropdownMenuItem<T?>(value: e.key, child: Text(e.value)),
              ],
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}