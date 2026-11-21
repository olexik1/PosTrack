import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_tracking_service/widgets/nav_textbutton.dart';
import 'package:mail_tracking_service/widgets/form_action_button.dart';
import 'package:mail_tracking_service/models/parcel_provider.dart';
import 'package:mail_tracking_service/models/parcel.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';
import 'package:mail_tracking_service/models/current_parcel_provider.dart';
import 'package:provider/provider.dart';
import 'package:mail_tracking_service/widgets/status_chip.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

class ParcelDetailsScreen extends StatelessWidget {
  final String previousDetailsRoute;
  const ParcelDetailsScreen({super.key, required this.previousDetailsRoute});

  @override
  Widget build(BuildContext context) {
    final parcelProvider = context.watch<ParcelProvider>();
    final currentParcelProvider = context.watch<CurrentParcelProvider>();
    final Parcel? parcel = parcelProvider.getParcelByID(currentParcelProvider.currentParcelId);

    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 48,
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: NavTextButton(
              destination: previousDetailsRoute,
              label: 'Назад до списку',
              icon: Icons.arrow_back,
              centered: false,
              bold: true,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        parcel?.title ?? "Посилка без назви",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    StatusChip(
                      status: parcel?.status ?? ParcelStatus.created,
                    ),
                  ],
                ),
              ),
              Row(
                spacing: 8,
                children: [
                  FormActionButton(
                      label: "Змінити статус",
                      onPressed: () {

                      },
                      fullWidth: false,
                      icon: Icons.access_time_outlined,
                  ),
                  FormActionButton(
                    label: "Редагувати",
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.link,
                    onPressed: () {

                    },
                    fullWidth: false,
                    icon: Icons.edit_outlined,
                  ),
                  FormActionButton(
                    label: "Видалити",
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.error,
                    onPressed: () {

                    },
                    fullWidth: false,
                    icon: Icons.delete_outline,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}