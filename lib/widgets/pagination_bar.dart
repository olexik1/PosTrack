import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

class PaginationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;
  final int elementsOnPage;
  final int totalElements;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const PaginationBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    required this.elementsOnPage,
    required this.totalElements,
    required this.onPrevious,
    required this.onNext
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.cardBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            'Показано $elementsOnPage відправлень з $totalElements',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Row(
            spacing: 8,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: AppColors.border),
                iconSize: 32,
                onPressed: currentPage > 1 ? onPrevious : null,
              ),
              Text(
                'Сторінка $currentPage з $totalPages',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: AppColors.border),
                iconSize: 32,
                onPressed: currentPage < totalPages ? onNext : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}