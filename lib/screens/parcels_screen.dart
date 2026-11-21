import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mail_tracking_service/models/parcel_carrier.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:mail_tracking_service/widgets/form_action_button.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';
import 'package:mail_tracking_service/widgets/filter_dropdown.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mail_tracking_service/models/parcel_provider.dart';
import 'package:mail_tracking_service/models/current_parcel_provider.dart';
import 'package:mail_tracking_service/widgets/search_field.dart';
import 'package:mail_tracking_service/widgets/parcel_list_tile.dart';
import 'package:mail_tracking_service/widgets/pagination_bar.dart';

class ParcelsScreen extends StatelessWidget {
  const ParcelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final parcelProvider = context.watch<ParcelProvider>();
    final currentParcelProvider = context.watch<CurrentParcelProvider>();

    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 48,
            vertical: 24,
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Мої посилки",
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 48,
                  child: FormActionButton(
                    label: "Нова посилка",
                    onPressed: () {

                    },
                    fullWidth: false,
                    icon: Icons.add_outlined,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                spacing: 16,
                children: [
                  SearchField(
                    value: parcelProvider.searchQuery,
                    onChanged: parcelProvider.setSearchQuery,
                    onSubmitted: parcelProvider.setSearchQuery,
                    color: AppColors.photoButton,
                    hintColor: AppColors.textSecondary,
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      FilterDropdown<ParcelStatus>(
                        label: 'Статус доставки',
                        value: parcelProvider.selectedStatus,
                        options: {
                          null: 'Всі статуси',
                          for (final status in ParcelStatus.values)
                            status: status.label,
                        },
                        onChanged: parcelProvider.setStatusFilter,
                      ),
                      FilterDropdown<ParcelCarrier>(
                        label: 'Перевізники',
                        value: parcelProvider.selectedCarrier,
                        options: {
                          null: 'Всі перевізники',
                          for (final carrier in ParcelCarrier.values)
                            carrier: carrier.label,
                        },
                        onChanged: parcelProvider.setCarrierFilter,
                      ),
                      FilterDropdown<SortOrder>(
                        label: 'Сортування',
                        value: parcelProvider.sortOrder,
                        options: {
                          for (final order in SortOrder.values)
                            order: order.label,
                        },
                        onChanged: (order) {
                          if (order != null) {
                            parcelProvider.setSortOrder(order);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (parcelProvider.visibleParcels.isEmpty)
              const Center(
                child: Text('Посилок не знайдено'),
              )
            else
              Column(
                spacing: 8,
                children: [
                  for (final parcel in parcelProvider.visibleParcels)
                    ParcelListTile(
                      parcel: parcel,
                      onDetails: () {
                        currentParcelProvider.setNew(parcel.id);
                        context.go('/parcel-details', extra: '/parcels');
                      },
                    ),
                ],
              ),
            PaginationBar(
                currentPage: parcelProvider.currentPage,
                totalPages: max(parcelProvider.totalPages, 1),
                onPageChanged: parcelProvider.setCurrentPage,
                elementsOnPage: parcelProvider.visibleParcels.length,
                totalElements: parcelProvider.totalFilteredParcels,
                onPrevious: parcelProvider.previousPage,
                onNext: parcelProvider.nextPage
            ),
          ],
        ),
      )
    );
  }
}