import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:mail_tracking_service/widgets/form_action_button.dart';
import 'package:mail_tracking_service/widgets/counter_card.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';
import 'package:mail_tracking_service/widgets/parcel_card.dart';
import 'package:mail_tracking_service/models/parcel_repository.dart';

class ParcelsScreen extends StatelessWidget {
  const ParcelsScreen({super.key});

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
          ],
        ),
      )
    );
  }
}