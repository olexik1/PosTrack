import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:mail_tracking_service/widgets/form_action_button.dart';
import 'package:mail_tracking_service/widgets/counter_card.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';
import 'package:mail_tracking_service/models/parcel.dart';
import 'package:mail_tracking_service/models/parcel_carrier.dart';
import 'package:mail_tracking_service/widgets/parcel_card.dart';
import 'package:mail_tracking_service/models/parcel_repository.dart';
import 'package:sentry/sentry.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  OutlineInputBorder _border(Color color, [double width = 1]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Пошук за ТТН або назвою",
                      hintStyle: const TextStyle(
                        color: AppColors.parcelInput,
                        fontSize: 14,
                      ),
                      border: _border(AppColors.parcelInputBorder),
                      enabledBorder: _border(AppColors.parcelInputBorder),
                      focusedBorder: _border(AppColors.primary, 1.5),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 12, right: 8),
                        child: Icon(
                          Icons.search_outlined,
                          color: AppColors.parcelInput,
                          size: 20,
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 24,
                      ),
                      constraints: const BoxConstraints.tightFor(height: 48),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
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
                    Expanded(
                      child: CounterCard(status: ParcelStatus.created,
                          count: ParcelRepository.countStatus(ParcelStatus.created)),
                    ),
                    Expanded(
                      child: CounterCard(status: ParcelStatus.accepted,
                          count: ParcelRepository.countStatus(ParcelStatus.accepted)),
                    ),
                    Expanded(
                      child: CounterCard(status: ParcelStatus.onTheRoad,
                          count: ParcelRepository.countStatus(ParcelStatus.onTheRoad)),
                    ),
                    Expanded(
                      child: CounterCard(status: ParcelStatus.arrived,
                          count: ParcelRepository.countStatus(ParcelStatus.arrived)),
                    ),
                    Expanded(
                      child: CounterCard(status: ParcelStatus.delivered,
                          count: ParcelRepository.countStatus(ParcelStatus.delivered)),
                    ),
                    Expanded(
                      child: CounterCard(status: ParcelStatus.returned,
                          count: ParcelRepository.countStatus(ParcelStatus.returned)),
                    ),
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
                  for (final p in ParcelRepository.getAll()) ParcelCard(parcel: p, onDetails: (){},),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}