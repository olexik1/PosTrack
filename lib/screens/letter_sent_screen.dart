import 'package:flutter/material.dart';
import 'package:mail_tracking_service/widgets/form_title.dart';
import 'package:mail_tracking_service/widgets/nav_textbutton.dart';
import 'package:mail_tracking_service/widgets/authentication_scaffold.dart';

class LetterSentScreen extends StatelessWidget {
  final String? email;

  const LetterSentScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return AuthenticationScaffold(child: LetterSentScreenForm(email: email));
  }
}

class LetterSentScreenForm extends StatelessWidget {
  final String? email;
  const LetterSentScreenForm({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        FormTitle(
          mainText: "Лист надіслано",
          subText:
          "Ми надіслали посилання для відновлення на ${email ?? 'вашу пошту'}. Перевірте пошту",
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: NavTextButton(
            destination: '/login',
            label: 'Повернутися до входу',
            icon: Icons.arrow_back,
            centered: true,
            bold: true,
          ),
        ),
      ],
    );
  }
}
