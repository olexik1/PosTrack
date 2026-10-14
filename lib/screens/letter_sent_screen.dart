import 'package:flutter/material.dart';
import 'package:mail_tracking_service/widgets/form_title.dart';
import 'package:mail_tracking_service/widgets/nav_textbutton.dart';
import 'package:mail_tracking_service/widgets/authentication_scaffold.dart';

class LetterSentScreen extends StatelessWidget {
  const LetterSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthenticationScaffold(child: const LetterSentScreenForm());
  }
}

class LetterSentScreenForm extends StatefulWidget {
  const LetterSentScreenForm({super.key});

  @override
  State<LetterSentScreenForm> createState() => _LetterSentScreenFormState();
}

class _LetterSentScreenFormState extends State<LetterSentScreenForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          FormTitle(
            mainText: "Лист надіслано",
            subText: "Ми надіслали посилання для відновлення на _. Перевірте пошту",
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
          )
        ],
      ),
    );
  }
}