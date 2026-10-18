import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum ParcelStatus {
  created('Створено', AppColors.statusCreatedText, AppColors.statusCreatedBg, Icons.edit_note),
  accepted('Прийнято', AppColors.statusAcceptedText, AppColors.statusAcceptedBg, Icons.assignment_turned_in_outlined),
  onTheRoad('В дорозі', AppColors.statusOnTheRoadText, AppColors.statusOnTheRoadBg, Icons.local_shipping_outlined),
  arrived('Прибула', AppColors.statusArrivedText, AppColors.statusArrivedBg, Icons.storefront_outlined),
  delivered('Доставлена', AppColors.statusDeliveredText, AppColors.statusDeliveredBg, Icons.check_circle_outline),
  returned('Повернена', AppColors.statusReturnedText, AppColors.statusReturnedBg, Icons.assignment_return_outlined);

  final String label;
  final Color textColor;
  final Color backgroundColor;
  final IconData icon;

  const ParcelStatus(this.label, this.textColor, this.backgroundColor, this.icon);
}