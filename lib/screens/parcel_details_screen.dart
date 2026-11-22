import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_tracking_service/widgets/change_status_dialog.dart';
import 'package:mail_tracking_service/widgets/delete_parcel_dialog.dart';
import 'package:mail_tracking_service/widgets/nav_textbutton.dart';
import 'package:mail_tracking_service/widgets/form_action_button.dart';
import 'package:mail_tracking_service/models/parcel_provider.dart';
import 'package:mail_tracking_service/models/parcel.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';
import 'package:provider/provider.dart';
import 'package:mail_tracking_service/widgets/status_chip.dart';
import 'package:mail_tracking_service/widgets/info_field.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:mail_tracking_service/widgets/parcel_photo_field.dart';
import 'package:mail_tracking_service/widgets/status_circle.dart';


class ParcelDetailsScreen extends StatelessWidget {
  final String previousDetailsRoute;
  final int? parcelId;
  const ParcelDetailsScreen({
    super.key,
    required this.previousDetailsRoute,
    required this.parcelId
  });

  @override
  Widget build(BuildContext context) {
    final parcelProvider = context.watch<ParcelProvider>();
    final Parcel? parcel = parcelProvider.getParcelByID(parcelId);

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
                      onPressed: () => showChangeStatusDialog(context,
                          currentStatus: parcel?.status ?? ParcelStatus.created),
                      fullWidth: false,
                      icon: Icons.access_time_outlined,
                  ),
                  FormActionButton(
                    label: "Редагувати",
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.link,
                    onPressed: () => context.go('/parcels/$parcelId/edit'),
                    fullWidth: false,
                    icon: Icons.edit_outlined,
                  ),
                  FormActionButton(
                    label: "Видалити",
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.error,
                    onPressed: () => showDeleteParcelDialog(context,
                        parcelTitle: parcel?.title ?? "Без назви"),
                    fullWidth: false,
                    icon: Icons.delete_outline,
                  ),
                ],
              ),
            ],
          ),
          Row(
            spacing: 24,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.photoButton,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                                Icons.inventory_2_outlined,
                                color: AppColors.link,
                                size: 16
                            ),
                          ),
                          Text(
                            "Інформація про посилку",
                            style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: 8,
                        children: [
                          InfoField(
                            title: "Трек-номер (ТТН)",
                            info: parcel?.trackingNumber ?? "-",
                            copy: true,
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              Expanded(
                                child: InfoField(
                                    title: "Служба доставки",
                                    info: parcel?.carrier.label ?? "-"
                                ),
                              ),
                              Expanded(
                                child: InfoField(
                                    title: "Дата створення",
                                    info: parcel != null
                                        ? DateFormat('d MMMM yyyy', 'uk').format(parcel.date)
                                        : '-'
                                ),
                              )
                            ],
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              Expanded(child: InfoField(
                                  title: "Відправник",
                                  info: parcel?.sender ?? "-"
                              )),
                              Expanded(child: InfoField(
                                  title: "Одержувач",
                                  info: parcel?.recipient ?? "-"
                              )),
                            ],
                          ),
                          InfoField(
                              title: "Примітка",
                              info: parcel?.note ?? "-"
                          ),
                          const ParcelPhotoField(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                child: Container(
                  padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.photoButton,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                                Icons.show_chart,
                                color: AppColors.link,
                                size: 16
                            ),
                          ),
                          Text(
                            "Історія зміни статусів",
                            style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),

                      if (parcel != null && parcel.statusHistory != null)
                        Builder(
                          builder: (context) {
                            final history = [...parcel.statusHistory!]
                              ..sort((a, b) => b.date.compareTo(a.date));

                            return Column(
                              children: [
                                for (int i = 0; i < history.length; i++)
                                  IntrinsicHeight(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Column(
                                          children: [
                                            StatusCircle(
                                              innerColor: history[i].status.textColor,
                                              outerColor: history[i].status.backgroundColor,
                                              big: i == 0,
                                            ),

                                            if (i != history.length - 1)
                                              Expanded(
                                                child: Container(
                                                  width: 2,
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                          ],
                                        ),

                                        const SizedBox(width: 16),

                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 24),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  history[i].status.label,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat(
                                                    'd MMMM yyyy',
                                                    'uk',
                                                  ).format(history[i].date),
                                                ),

                                                if (history[i].branch != null &&
                                                    history[i].branch!.isNotEmpty)
                                                  Text(history[i].branch!),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),

                                        Text(
                                          DateFormat('HH:mm')
                                              .format(history[i].date),
                                          style: const TextStyle(
                                            color: AppColors.textSecondary,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            );
                          },
                        )
                      else
                        const Text('Історія статусів недоступна'),

                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}