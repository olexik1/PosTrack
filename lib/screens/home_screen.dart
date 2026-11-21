import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:mail_tracking_service/widgets/form_action_button.dart';
import 'package:mail_tracking_service/widgets/counter_card.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';
import 'package:mail_tracking_service/widgets/parcel_card.dart';
import 'package:mail_tracking_service/models/parcel_provider.dart';
import 'package:mail_tracking_service/models/current_parcel_provider.dart';
import 'package:mail_tracking_service/widgets/search_field.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
// import 'package:sentry/sentry.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final parcelProvider = context.watch<ParcelProvider>();
    final currentParcelProvider = context.read<CurrentParcelProvider>();

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
                  "Головна",
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 300,
                  child: SearchField(
                      value: parcelProvider.searchQuery,
                      onChanged: parcelProvider.setSearchQuery,
                      onSubmitted: (_) => context.go('/parcels'),
                      color: Colors.white,
                      hintColor: AppColors.parcelInput
                  )
                ),
                const SizedBox(width: 8),
                SizedBox(height: 48,
                child: FormActionButton(
                    label: "Додати посилку",
                    onPressed: () {
                      // Sentry.captureException(Exception('Тестова помилка PosTrack'));
                    },
                    fullWidth: false,
                    icon: Icons.add_outlined,
                  ),
                ),
              ],
            ),
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "СТАТУС ДОСТАВКИ",
                  style: TextStyle(
                    color: AppColors.hint,
                    fontSize: 12,
                  ),
                ),
                Row(
                  spacing: 8,
                  children: [
                    for(final s in ParcelStatus.values) ...[
                        Expanded(
                          child: CounterCard(
                            status: s,
                            count: parcelProvider.countByStatus(s),
                          ),
                        ),
                    ],
                  ],
                ),
              ],
            ),
            Text(
              "Останні посилки",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                spacing: 8,
                children: [
                  for (final p in parcelProvider.recentParcels(3)) ParcelCard(parcel: p,
                    onDetails: () {
                      currentParcelProvider.setNew(p.id);
                      context.go('/parcel-details', extra: '/home');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}